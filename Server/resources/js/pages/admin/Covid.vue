<template>
    <div class="container">
        <div class="card card-default">
            <div class="card-header">
                <h3>Covid-19 manage</h3>
            </div>
            <div class="card-body">
                <covid19List></covid19List>
            </div>
        </div>
    </div>
</template>

<script>
    import covid19List from '../../components/covid19List.vue'
    export default {
        mounted() {
            //
        },
        components: {
            covid19List
        }
    }
</script>
