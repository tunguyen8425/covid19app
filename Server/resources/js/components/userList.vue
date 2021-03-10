<template>
<div>
    <div class="alert alert-danger" v-if="has_error">
        <p>Error!</p>
    </div>
    <button type="button" v-on:click="newUser()" class="btn btn-primary btn-fw mb-3">New user</button>
    <table class="table table-bordered">
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">Email</th>
            <th scope="col">Gender</th>
            <th scope="col">Phone</th>
            <th scope="col">Created date</th>
            <th scope="col" class="align-center">
                <div>
                    Actions
                </div>
            </th>
        </tr>
        <tr v-for="user in users" v-bind:key="user.id" style="margin-bottom: 5px;">
            <th scope="row">{{ user.id }}</th>
            <td>{{ user.name }}</td>
            <td>{{ user.email }}</td>
            <td v-if="user.gender == 1">
                Male
            </td>
            <td v-if="user.gender == 2">
                Female
            </td>
            <td v-if="user.gender == 3">
                Others
            </td>
            <td>{{ user.phone }}</td>
            <td>{{ user.created_at}}</td>
            <td v-if="user.role == 1" class="action-button align-center">
                <div v-on:click="editUser(user.id)"><button type="submit" class="btn btn-success mr-2">Change</button></div>
                <div v-on:click="deleteUser(user.id)"><button type="submit" class="btn btn-danger">Delete</button></div>
            </td>
            <td v-else>
            </td>

        </tr>
    </table>

</div>
</template>

<script>
    export default {
        data() {
            return {
                has_error: false,
                users: null
            }
        },

        mounted() {
            this.getUsers()
        },

        methods: {
            getUsers() {
                this.$http({
                    url: `users`,
                    method: 'GET'
                })
                    .then((res) => {
                        this.users = res.data.users
                    }, () => {
                        this.has_error = true
                    })
            },
            newUser(){
                const swalWithBootstrapButtons = Swal.mixin({
                    customClass: {
                        confirmButton: 'btn btn-success mr-2',
                        cancelButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                })
                let data;
                swalWithBootstrapButtons.fire({
                    html:
                        '<form class="forms-sample">'
                        + '<div class="form-group row">'
                        + '<label for="new-name" class="col-sm-3 col-form-label">Name</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="text" class="form-control" id="new-name" placeholder="Name">'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="new-email" class="col-sm-3 col-form-label">Email</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="email" class="form-control" id="new-email" placeholder="Email">'
                        + '</div>'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="new-phone" class="col-sm-3 col-form-label">Phone</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="email" class="form-control" id="new-phone" placeholder="01234567890">'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row ml-4">'
                        + '<div class="form-check-inline">'
                        + '<label class="form-check-label">'
                        + '<input type="radio" class="form-check-input" checked name="gender" value="1">Male'
                        + '</label>'
                        + '</div>'
                        + '<div class="form-check-inline">'
                        + '<label class="form-check-label">'
                        + '<input type="radio" class="form-check-input" name="gender" value="2">Female'
                        + '</label>'
                        + '</div>'
                        + '<div class="form-check-inline">'
                        + '<label class="form-check-label">'
                        + '<input type="radio" class="form-check-input" name="gender" value="3">Others'
                        + '</label>'
                        + '</div>'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="new-password" class="col-sm-3 col-form-label">Password</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="password" class="form-control" id="new-password" placeholder="Password">'
                        + '</div>'
                        + '</div>'
                        + '</div>'
                        + '</form>',
                    showCancelButton: true,
                    confirmButtonText: 'Create',
                    cancelButtonText: 'Cancel',
                }).then((result) => {
                    data = 'name=';
                    data += $('#new-name').val();
                    data += '&email=';
                    data += $('#new-email').val();
                    data += '&phone=';
                    data += $('#new-phone').val();
                    data += '&gender=';
                    data += $("input[name='gender']:checked").val();
                    data += '&password=';
                    data += $('#new-password').val();
                    if (result.value) {
                        this.$http({
                            url: `user`,
                            method: 'POST',
                            data : data
                        })
                            .then((res) => {
                                this.getUsers()
                                swalWithBootstrapButtons.fire(
                                    'Created!',
                                    'Your file has been created.',
                                    'success'
                                )
                            }, () => {
                                this.has_error = true
                            })
                    } else if (
                        /* Read more about handling dismissals below */
                        result.dismiss === Swal.DismissReason.cancel
                    ) {
                        swalWithBootstrapButtons.fire(
                            'Cancelled',
                            'Your imaginary file is safe :)',
                            'error'
                        )
                    }
                })
            },
            editUser(id){
                this.$http({
                    url: `user/` + id,
                    method: 'GET',
                })
                    .then((res) => {
                        const swalWithBootstrapButtons = Swal.mixin({
                            customClass: {
                                confirmButton: 'btn btn-success mr-2',
                                cancelButton: 'btn btn-danger'
                            },
                            buttonsStyling: false
                        })
                        let data;
                        swalWithBootstrapButtons.fire({
                            html:
                                '<form class="forms-sample">'
                                + '<div class="form-group row">'
                                + '<label for="new-name" class="col-sm-3 col-form-label">Name</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" id="new-name" placeholder="Name" value="'
                                + res.data.user.name
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-email" class="col-sm-3 col-form-label">Email</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" id="new-email" placeholder="Email" value="'
                                + res.data.user.email
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Phone</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" id="new-phone" placeholder="Email" value="'
                                + res.data.user.phone
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row ml-5">'
                                + '<div class="form-check-inline">'
                                + '<label class="form-check-label">'
                                + '<input type="radio" class="form-check-input" name="gender" checked value="1">Male'
                                + '</label>'
                                + '</div>'
                                + '<div class="form-check-inline">'
                                + '<label class="form-check-label">'
                                + '<input type="radio" class="form-check-input" name="gender" value="2">Female'
                                + '</label>'
                                + '</div>'
                                + '<div class="form-check-inline">'
                                + '<label class="form-check-label">'
                                + '<input type="radio" class="form-check-input" name="gender" value="3">Others'
                                + '</label>'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</form>',
                            showCancelButton: true,
                            confirmButtonText: 'Update',
                            cancelButtonText: 'Cancel',
                        }).then((result) => {
                            data = 'name=';
                            data += $('#new-name').val();
                            data += '&email=';
                            data += $('#new-email').val();
                            data += '&phone=';
                            data += $('#new-phone').val();
                            data += '&gender=';
                            data += $("input[name='gender']:checked").val();
                            if (result.value) {
                                this.$http({
                                    url: `user/` + id,
                                    method: 'PUT',
                                    data : data
                                })
                                    .then((res) => {
                                        this.getUsers()
                                        swalWithBootstrapButtons.fire(
                                            'Created!',
                                            'Your file has been created.',
                                            'success'
                                        )
                                    }, () => {
                                        this.has_error = true
                                    })
                            } else if (
                                /* Read more about handling dismissals below */
                                result.dismiss === Swal.DismissReason.cancel
                            ) {
                                swalWithBootstrapButtons.fire(
                                    'Cancelled',
                                    'Your imaginary file is safe :)',
                                    'error'
                                )
                            }
                        })
                    }, () => {
                        this.has_error = true
                    })
            },
            deleteUser(id){
                const swalWithBootstrapButtons = Swal.mixin({
                    customClass: {
                        confirmButton: 'btn btn-success mr-2',
                        cancelButton: 'btn btn-danger'
                    },
                    buttonsStyling: false
                })

                swalWithBootstrapButtons.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to revert this!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'No, cancel!',
                }).then((result) => {
                    if (result.value) {
                        this.$http({
                            url: `user/` + id,
                            method: 'DELETE'
                        })
                            .then((res) => {
                                this.getUsers()
                                swalWithBootstrapButtons.fire(
                                    'Deleted!',
                                    'Your file has been deleted.',
                                    'success'
                                )
                            }, () => {
                                this.has_error = true
                            })
                    } else if (
                        /* Read more about handling dismissals below */
                        result.dismiss === Swal.DismissReason.cancel
                    ) {
                        swalWithBootstrapButtons.fire(
                            'Cancelled',
                            'Your imaginary file is safe :)',
                            'error'
                        )
                    }
                })
            }
        }
    }
</script>
