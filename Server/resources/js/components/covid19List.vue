<template>
    <div>
        <div class="alert alert-danger" v-if="has_error">
            <p>Error!</p>
        </div>

        <table class="table table-bordered">
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Name</th>
                <th scope="col">National Id</th>
                <th scope="col">Insurance Id</th>
                <th scope="col">Date of birth</th>
                <th scope="col" class="align-center">
                    <div>
                    Actions
                    </div>
                 </th>
            </tr>
            <tr v-for="covid19 in covid19s" v-bind:key="covid19.id" style="margin-bottom: 5px;">
                <th scope="row">{{ covid19.id }}</th>
                <td>{{ covid19.name }}</td>
                <td>{{ covid19.national_id }}</td>
                <td>{{ covid19.insurance_id }}</td>
                <td>{{ covid19.date_of_birth }}</td>
                <td class="action-button align-center">
                    <div v-on:click="showCovid19(covid19.id)"><button type="submit" class="btn btn-success mr-2">Show</button></div>
                    <div v-on:click="deleteCovid19(covid19.id)"><button type="submit" class="btn btn-danger">Delete</button></div>
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
                covid19s: null
            }
        },

        mounted() {
            this.getCovid19()
        },

        methods: {
            getCovid19() {
                this.$http({
                    url: `covid19s`,
                    method: 'GET'
                })
                    .then((res) => {
                        this.covid19s = res.data.covid19s
                    }, () => {
                        this.has_error = true
                    })
            },
            showCovid19(id){
                this.$http({
                    url: `covid19/` + id,
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
                                + '<input type="text" class="form-control" placeholder="Name" value="'
                                + res.data.covid19.name
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-email" class="col-sm-3 col-form-label">Email</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" placeholder="Email" value="'
                                + res.data.covid19.phone
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Phone</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" placeholder="Email" value="'
                                + res.data.covid19.email
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Address</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" placeholder="Address" value="'
                                + res.data.covid19.address
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">City</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" placeholder="City" value="'
                                + res.data.covid19.city
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
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Date of Birth</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" placeholder="Date of Birth" value="'
                                + res.data.covid19.date_of_birth
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">National ID</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" placeholder="National ID" value="'
                                + res.data.covid19.national_id
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Insurance ID</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" placeholder="Insurance ID" value="'
                                + res.data.covid19.insurance_id
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</div>'
                                + '</form>',
                            showCancelButton: false,
                            confirmButtonText: 'OK',
                        }).then((result) => {
                            this.getCovid19();
                        })
                    }, () => {
                        this.has_error = true
                    })
            },
            deleteCovid19(id){
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
                            url: `covid19/` + id,
                            method: 'DELETE'
                        })
                            .then((res) => {
                                this.getCovid19()
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
