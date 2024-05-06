Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4048BC63B
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 05:35:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VXn9C34SVz30TR
	for <lists+linux-erofs@lfdr.de>; Mon,  6 May 2024 13:35:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.51; helo=dggsgout11.his.huawei.com; envelope-from=libaokun@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VXn951TcHz2yvv
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 13:35:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXn8l70Wnz4f3nTq
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 11:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B37821A016E
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 May 2024 11:34:57 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g7dTzhmNL6JLw--.30952S3;
	Mon, 06 May 2024 11:34:57 +0800 (CST)
Message-ID: <8b6d5c37-69ed-0554-069e-209ce2ead016@huaweicloud.com>
Date: Mon, 6 May 2024 11:34:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 09/12] cachefiles: defer exposing anon_fd until after
 copy_to_user() succeeds
Content-Language: en-US
To: Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-10-libaokun@huaweicloud.com>
 <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <e0fc24d5-49c5-4a75-86f9-43adc763066f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAX5g7dTzhmNL6JLw--.30952S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4fXryxXFWUWry5Gw1Dtrb_yoW7Cr1fpF
	ZIkFW3KFy8WFW8ur97AFZ8XFySy3y8AFnrW34Fga4rArnFgr1F9r10kr98uF1rAr97Grs3
	tF4UC3s3Gr1jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
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
Cc: libaokun@huaweicloud.com, yangerkun <yangerkun@huawei.com>, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/5/6 11:24, Jingbo Xu wrote:
>
> On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> After installing the anonymous fd, we can now see it in userland and close
>> it. However, at this point we may not have gotten the reference count of
>> the cache, but we will put it during colse fd, so this may cause a cache
>> UAF.
> Good catch!
>
>> To avoid this, we will make the anonymous fd accessible to the userland by
>> executing fd_install() after copy_to_user() has succeeded, and by this
>> point we must have already grabbed the reference count of the cache.
> Why we must execute fd_install() after copy_to_user() has succeeded?
> Why not grab a reference to the cache before fd_install()?
Two things are actually done here:
1) Grab a reference to the cache before fd_install()
2) By kernel convention, fd is taken over by the user land after
fd_install() is executed, and the kernel does not call close_fd() after
this, so fd_install() is called after everything is ready.

Thanks,
Baokun
>
>> Suggested-by: Hou Tao <houtao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/cachefiles/ondemand.c | 53 +++++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
>> index 0cf63bfedc9e..7c2d43104120 100644
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
>> @@ -244,14 +249,14 @@ int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
>>   	return 0;
>>   }
>>   
>> -static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>> +static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
>> +				      struct anon_file *anon_file)
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
>> @@ -263,16 +268,16 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
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
>> @@ -281,15 +286,14 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   		spin_unlock(&object->ondemand->lock);
>>   		ret = -EEXIST;
>>   		/* Avoid performing cachefiles_ondemand_fd_release(). */
>> -		file->private_data = NULL;
>> +		anon_file->file->private_data = NULL;
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
>> @@ -298,9 +302,11 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>>   	return 0;
>>   
>>   err_put_file:
>> -	fput(file);
>> +	fput(anon_file->file);
>> +	anon_file->file = NULL;
>>   err_put_fd:
>> -	put_unused_fd(fd);
>> +	put_unused_fd(anon_file->fd);
>> +	anon_file->fd = ret;
>>   err_free_id:
>>   	xa_erase(&cache->ondemand_ids, object_id);
>>   err:
>> @@ -357,6 +363,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	struct cachefiles_msg *msg;
>>   	size_t n;
>>   	int ret = 0;
>> +	struct anon_file anon_file;
>>   	XA_STATE(xas, &cache->reqs, cache->req_id_next);
>>   
>>   	xa_lock(&cache->reqs);
>> @@ -390,7 +397,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	xa_unlock(&cache->reqs);
>>   
>>   	if (msg->opcode == CACHEFILES_OP_OPEN) {
>> -		ret = cachefiles_ondemand_get_fd(req);
>> +		ret = cachefiles_ondemand_get_fd(req, &anon_file);
>>   		if (ret)
>>   			goto out;
>>   	}
>> @@ -398,10 +405,16 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
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


