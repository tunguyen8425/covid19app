<template>
    <div class="container">
        <div class="card card-default">
            <div class="card-header">
                <h3>User manage</h3>
            </div>
            <div class="card-body">
                <userList></userList>
            </div>
        </div>
    </div>
</template>

<script>
    import userList from '../../components/userList.vue'
    export default {
        mounted() {
            //
        },
        components: {
            userList
        }
    }
</script>
