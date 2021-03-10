<template>
<div>
    <div class="alert alert-danger" v-if="has_error">
        <p>Error!</p>
    </div>
    <button type="button" v-on:click="newHospital()" class="btn btn-primary btn-fw mb-3">New hospital</button>
    <table class="table table-bordered">
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">Address</th>
            <th scope="col">Descrtiption</th>
            <th scope="col" class="align-center">
                <div>
                    Actions
                </div>
            </th>
        </tr>
        <tr v-for="hospital in hospitals" v-bind:key="hospital.id" style="margin-bottom: 5px;">
            <th scope="row">{{ hospital.id }}</th>
            <td>{{ hospital.name }}</td>
            <td>{{ hospital.address }}</td>
            <td>{{ hospital.description}}</td>
            <td class="action-button align-center">
                <div v-on:click="editHospital(hospital.id)"><button type="submit" class="btn btn-success mr-2">Change</button></div>
                <div v-on:click="deleteHospital(hospital.id)"><button type="submit" class="btn btn-danger">Delete</button></div>
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
                hospitals: null
            }
        },

        mounted() {
            this.getHospitals()
        },

        methods: {
            getHospitals() {
                this.$http({
                    url: `hospitals`,
                    method: 'GET'
                })
                    .then((res) => {
                        this.hospitals = res.data.hospitals
                    }, () => {
                        this.has_error = true
                    })
            },
            newHospital(){
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
                        + '<label for="exampleInputUsername2" class="col-sm-3 col-form-label">Name</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="text" class="form-control" id="new-name" placeholder="Name">'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="exampleInputEmail2" class="col-sm-3 col-form-label">Address</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="text" class="form-control" id="new-address" placeholder="Address">'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="exampleInputEmail2" class="col-sm-3 col-form-label">Map Address</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="text" class="form-control" id="new-mapaddress" placeholder="Map Address">'
                        + '</div>'
                        + '</div>'
                        + '<div class="form-group row">'
                        + '<label for="exampleInputMobile" class="col-sm-3 col-form-label">Description</label>'
                        + '<div class="col-sm-9">'
                        + '<input type="text" class="form-control" id="new-description" placeholder="Description">'
                        + '</div>'
                        + '</div>'
                        + '</form>',
                    showCancelButton: true,
                    confirmButtonText: 'Create',
                    cancelButtonText: 'Cancel',
                }).then((result) => {
                    data = 'name=';
                    data += $('#new-name').val();
                    data += '&address=';
                    data += $('#new-address').val();
                    data += '&mapaddress=';
                    data += $('#new-mapaddress').val();
                    data += '&description=';
                    data += $('#new-description').val();
                    if (result.value) {
                        this.$http({
                            url: `hospital`,
                            method: 'POST',
                            data : data
                        })
                            .then((res) => {
                                this.getHospitals()
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
            editHospital(id){
                this.$http({
                    url: `hospital/` + id,
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
                        console.log(res.data.hospital);
                        swalWithBootstrapButtons.fire({
                            html:
                                '<form class="forms-sample">'
                                + '<div class="form-group row">'
                                + '<label for="exampleInputUsername2" class="col-sm-3 col-form-label">Name</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" id="new-name" placeholder="Name" value="'
                                + res.data.hospital.name
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="exampleInputEmail2" class="col-sm-3 col-form-label">Address</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" id="new-address" placeholder="Address" value="'
                                + res.data.hospital.address
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="exampleInputEmail2" class="col-sm-3 col-form-label">Map Address</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" id="new-mapaddress" placeholder="Map Address" value="'
                                + res.data.hospital.map_address
                                + '">'
                                + '</div>'
                                + '</div>'
                                + '<div class="form-group row">'
                                + '<label for="exampleInputEmail2" class="col-sm-3 col-form-label">Description</label>'
                                + '<div class="col-sm-9">'
                                + '<input type="text" class="form-control" id="new-description" placeholder="Description" value="'
                                + res.data.hospital.description
                                + '">'
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
                            data += '&address=';
                            data += $('#new-address').val();
                            data += '&mapaddress=';
                            data += $('#new-mapaddress').val();
                            data += '&description=';
                            data += $('#new-description').val();
                            if (result.value) {
                                this.$http({
                                    url: `hospital/` + id,
                                    method: 'PUT',
                                    data : data
                                })
                                    .then((res) => {
                                        this.getHospitals()
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
            deleteHospital(id){
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
                            url: `hospital/` + id,
                            method: 'DELETE'
                        })
                            .then((res) => {
                                this.getHospitals()
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
