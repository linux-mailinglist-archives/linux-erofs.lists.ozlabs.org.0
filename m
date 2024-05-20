Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A98C9C66
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 13:46:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VjbBn0CkZz3cfy
	for <lists+linux-erofs@lfdr.de>; Mon, 20 May 2024 21:37:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjbBf4xsvz3cXR
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 21:36:56 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VjbBP32Xdz4f3jkJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 19:36:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 284821A0C48
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 May 2024 19:36:51 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7PNUtm6nK8NA--.6529S3;
	Mon, 20 May 2024 19:36:50 +0800 (CST)
Message-ID: <a9e39b5f-4397-056e-7f6c-b1a1847429dd@huaweicloud.com>
Date: Mon, 20 May 2024 19:36:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-10-libaokun@huaweicloud.com>
 <db7ae78c-857b-45ba-94dc-63c02757e0b2@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <db7ae78c-857b-45ba-94dc-63c02757e0b2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAn9g7PNUtm6nK8NA--.6529S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww43ur4fZw43CFW5XF1fJFb_yoWxJr1kpF
	WakFW3KFy8WFW8urn7AFZ8XFySy3y8A3ZrW34Fga4rArnFgryF9r1jkr98uF15Ar97Grs3
	tF4UCr97Gr1jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: libaokun@huaweicloud.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/5/20 17:39, Jingbo Xu wrote:
>
> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> After installing the anonymous fd, we can now see it in userland and close
>> it. However, at this point we may not have gotten the reference count of
>> the cache, but we will put it during colse fd, so this may cause a cache
>> UAF.
>>
>> So grab the cache reference count before fd_install(). In addition, by
>> kernel convention, fd is taken over by the user land after fd_install(),
>> and the kernel should not call close_fd() after that, i.e., it should call
>> fd_install() after everything is ready, thus fd_install() is called after
>> copy_to_user() succeeds.
>>
>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index d2d4e27fca6f..3a36613e00a7 100644
>> --- a/fs/cachefiles/ondemand.c
>> +++ b/fs/cachefiles/ondemand.c
>> @@ -4,6 +4,11 @@
>>   #include <linux/uio.h>
>>   #include "internal.h"
>>   
>> +struct anon_file {
>> +	struct file *file;
>> +	int fd;
>> +};
>> +
>>   static inline void cachefiles_req_put(struct cachefiles_req *req)
>>   {
>>   	if (refcount_dec_and_test(&req->ref))
>> @@ -263,14 +268,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>>   	return 0;
>>   }
>>   
>
>> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
>> +				      struct anon_file *anon_file)
>
> How about:
>
> int cachefiles_ondemand_get_fd(struct cachefiles_req *req, int *fd,
> struct file *file) ?
>
> It isn't worth introducing a new structure as it is used only for
> parameter passing.
>
It's just a different code style preference, and internally we think

it makes the code look clearer when encapsulated this way.

>>   {
>>   	struct cachefiles_object *object;
>>   	struct cachefiles_cache *cache;
>>   	struct cachefiles_open *load;
>> -	struct file *file;
>>   	u32 object_id;
>> -	int ret, fd;
>> +	int ret;
>>   
>>   	object = cachefiles_grab_object(req->object,
>>   			cachefiles_obj_get_ondemand_fd);
>> @@ -282,16 +287,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	if (ret < 0)
>>   		goto err;
>>   
>> -	fd = get_unused_fd_flags(O_WRONLY);
>> -	if (fd < 0) {
>> -		ret = fd;
>> +	anon_file->fd = get_unused_fd_flags(O_WRONLY);
>> +	if (anon_file->fd < 0) {
>> +		ret = anon_file->fd;
>>   		goto err_free_id;
>>   	}
>>   
>> -	file = anon_inode_getfile("[cachefiles]", &cachefiles_ondemand_fd_fops,
>> -				  object, O_WRONLY);
>> -	if (IS_ERR(file)) {
>> -		ret = PTR_ERR(file);
>> +	anon_file->file = anon_inode_getfile("[cachefiles]",
>> +				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
>> +	if (IS_ERR(anon_file->file)) {
>> +		ret = PTR_ERR(anon_file->file);
>>   		goto err_put_fd;
>>   	}
>>   
>> @@ -299,16 +304,15 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	if (object->ondemand->ondemand_id > 0) {
>>   		spin_unlock(&object->ondemand->lock);
>>   		/* Pair with check in cachefiles_ondemand_fd_release(). */
>> -		file->private_data = NULL;
>> +		anon_file->file->private_data = NULL;
>>   		ret = -EEXIST;
>>   		goto err_put_file;
>>   	}
>>   
>> -	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>> -	fd_install(fd, file);
>> +	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>>   
>>   	load = (void *)req->msg.data;
>> -	load->fd = fd;
>> +	load->fd = anon_file->fd;
>>   	object->ondemand->ondemand_id = object_id;
>>   	spin_unlock(&object->ondemand->lock);
>>   
>> @@ -317,9 +321,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	return 0;
>>   
>>   err_put_file:
>> -	fput(file);
>> +	fput(anon_file->file);
>> +	anon_file->file = NULL;
> When cachefiles_ondemand_get_fd() returns failure, anon_file->file is
> not used, and thus I don't think it is worth resetting anon_file->file
> to NULL. Or we could assign fd and struct file at the very end when all
> succeed.
Nulling pointers that are no longer in use is a safer coding convention,
which goes some way to avoiding double free or use-after-free.
Moreover it's in the error branch, so it doesn't cost anything.
>>   err_put_fd:
>> -	put_unused_fd(fd);
>> +	put_unused_fd(anon_file->fd);
>> +	anon_file->fd = ret;
> Ditto.
>
>>   err_free_id:
>>   	xa_erase(&cache->ondemand_ids, object_id);
>>   err:
>> @@ -376,6 +382,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	struct cachefiles_msg *msg;
>>   	size_t n;
>>   	int ret = 0;
>> +	struct anon_file anon_file;
>>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>>   
>>   	xa_lock(&cache->reqs);
>> @@ -409,7 +416,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	xa_unlock(&cache->reqs);
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> -		ret = cachefiles_ondemand_get_fd(req);
>> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>>   		if (ret)
>>   			goto out;
>>   	}
>> @@ -417,10 +424,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	msg->msg_id = xas.xa_index;
>>   	msg->object_id = req->object->ondemand->ondemand_id;
>>   
>> -	if (copy_to_user(_buffer, msg, n) != 0) {
>> +	if (copy_to_user(_buffer, msg, n) != 0)
>>   		ret = -EFAULT;
>> -		if (msg->opcode == CACHEFILES_OP_OPEN)
>> -			close_fd(((struct cachefiles_open *)msg->data)->fd);
>> +
>> +	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> +		if (ret < 0) {
>> +			fput(anon_file.file);
>> +			put_unused_fd(anon_file.fd);
>> +			goto out;
>> +		}
>> +		fd_install(anon_file.fd, anon_file.file);
>>   	}
>>   out:
>>   	cachefiles_put_object(req->object, cachefiles_obj_put_read_req);


-- 
With Best Regards,
Baokun Li

