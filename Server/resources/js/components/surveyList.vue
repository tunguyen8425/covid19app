<template>
    <div>
        <div class="alert alert-danger" v-if="has_error">
            <p>Error!</p>
        </div>

        <table class="table table-bordered">
            <tr>
                <th scope="col">Id</th>
                <th scope="col">User id</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Title</th>
                <th scope="col" class="align-center">
                    <div>
                        Actions
                    </div>
                </th>
            </tr>
            <tr v-for="survey in surveys" v-bind:key="survey.id" style="margin-bottom: 5px;">
                <th scope="row">{{ survey.id }}</th>
                <td>{{ survey.user_id }}</td>
                <td>{{ user[survey.user_id].name }}</td>
                <td>{{ user[survey.user_id].email }}</td>
                <td>{{ survey.title }}</td>
                <td class="action-button align-center">
                    <div v-on:click="showSurvey(survey.id)"><button type="submit" class="btn btn-success mr-2">Show</button></div>
                    <div v-on:click="deleteSurvey(survey.id)"><button type="submit" class="btn btn-danger">Delete</button></div>
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
                surveys: null,
                user : null
            }
        },

        mounted() {
            this.getSurveys()
        },

        methods: {
            getSurveys() {
                this.$http({
                    url: `surveys`,
                    method: 'GET'
                })
                    .then((res) => {
                        this.surveys = res.data.surveys
                        this.user = res.data.user
                    }, () => {
                        this.has_error = true
                    })
            },
            showSurvey(id){
                this.$http({
                    url: `survey/` + id,
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
                                + res.data.user.name
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-email" class="col-sm-3 col-form-label">Email</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" placeholder="Email" value="'
                                + res.data.user.email
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Phone</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" placeholder="Email" value="'
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
                                + '<div class="form-group row">'
                                + '<label for="new-phone" class="col-sm-3 col-form-label">Symptom</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="email" class="form-control" placeholder="Symptom" value="'
                                + res.data.survey.title
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
                            this.getSurveys();
                        })
                    }, () => {
                        this.has_error = true
                    })
            },
            deleteSurvey(id){
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
                            url: `survey/` + id,
                            method: 'DELETE'
                        })
                            .then((res) => {
                                this.getSurveys()
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
