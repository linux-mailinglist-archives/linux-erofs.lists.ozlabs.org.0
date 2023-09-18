Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D617A4556
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Sep 2023 11:02:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RpzMF45MCz3bt2
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Sep 2023 19:02:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RpzM56W0rz30fD
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Sep 2023 19:02:07 +1000 (AEST)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id B76B01008A5EC;
	Mon, 18 Sep 2023 17:01:57 +0800 (CST)
Received: from [192.168.61.89] (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 03D9F37C967;
	Mon, 18 Sep 2023 17:01:53 +0800 (CST)
Message-ID: <afc85f30-948f-405c-8c52-f696666d1e5e@sjtu.edu.cn>
Date: Mon, 18 Sep 2023 17:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Li Yiyan <lyy0627@sjtu.edu.cn>
Subject: Re: [PATCH v9] erofs-utils: add support for fuse 2/3 lowlevel API
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230903113823.873232-1-lyy0627@sjtu.edu.cn>
 <26f9be6d-34c0-3c40-ba88-1c9c3af9ee02@linux.alibaba.com>
In-Reply-To: <26f9be6d-34c0-3c40-ba88-1c9c3af9ee02@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang:

Thanks for your thoughtful comments, here are my replies. 

On 2023/9/17 00:13, Gao Xiang wrote:
> 
> 
> On 2023/9/3 19:38, Li Yiyan wrote:
>> Hi Xiang:

...

>> +struct erofsfuse_readdir_context {
>>       struct erofs_dir_context ctx;
>> -    fuse_fill_dir_t filler;
>> -    struct fuse_file_info *fi;
>> +
>> +    fuse_req_t req;
>>       void *buf;
>> +    int is_plus;
>> +    size_t offset;
>> +    size_t buf_size;
> 
> please rename it as buf_rem;
> 

Thanks.

>> +    size_t start_off;
>> +    struct fuse_file_info *fi;
>> +};
>> +
>> +
>> +static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
>>   {
>> -    struct erofsfuse_dir_context *fusectx = (void *)ctx;
>> -    struct stat st = {0};
>> +    size_t size = 0;
> 
> please rename it as entsize,  or see:
> https://github.com/libfuse/libfuse/blob/master/example/passthrough_ll.c#L665
> 
> There are many `size`s here, I'm not sure which size you're meaning.
> 

It's acutally entsize, I'll fix it in V10.

>>       char dname[EROFS_NAME_LEN + 1];
>> +    struct erofsfuse_readdir_context *readdir_ctx = (void *)ctx;
>> +
>> +    if (readdir_ctx->offset < readdir_ctx->start_off) {
>> +        readdir_ctx->offset +=
>> +            ctx->de_namelen + sizeof(struct erofs_dirent);
> 
> I still don't think it's right.
> 
> First, if you treat it as an real offset of directory file, this
>        calculation is incorrect.  There are many reasons, the
>        obvious one is that "each directory block may have trailing
>        padding data"
> 
> Second, if you just treat it as an "index", for example.  Then,
>         I don't really understand why you rename
> 
>       readdir_ctx->offset => readdir_ctx->index
>       readdir_ctx->start_off => readdir_ctx->offset
> 
> and make readdir_ctx->index add by one for each iteration?
> 
> Anyway, this part seems quite odd to me.

You are right, in fact readdir_ctx->offset is a marker to
identify the current point in the directory stream. Rename it
to index and add one for each iteration indeed avoids
confusing. I'll fix it in V10.

>> +        st.st_mode = erofs_ftype_to_mode(ctx->de_ftype, 0);
>> +        st.st_ino = ctx->de_nid;
> 
> I think it's buggy here, I think you need to:
>         st.st_ino = erofsfuse_to_ino(ctx->de_nid);
> 

Thanks.
...

>> +        size = fuse_add_direntry_plus(readdir_ctx->req,
>> +                          readdir_ctx->buf,
>> +                          readdir_ctx->buf_size, dname,
>> +                          &param, readdir_ctx->offset);
> 
> Please
> 
>   #else
>         return -EOPNOTSUPP;
> 
> here.
> 

Thanks.

>> +static inline void erofsfuse_readdir_general(fuse_req_t req, fuse_ino_t ino,
>> +                         size_t size, off_t off,
>> +                         struct fuse_file_info *fi,
>> +                         int plus)
>> +{
>> +    int ret = 0;
>> +    char *buf = NULL;
>> +    struct erofsfuse_readdir_context ctx;
> 
> I'd suggest to use
>     struct erofsfuse_readdir_context ctx = {};
> 
> to avoid potential uninitialization.

Thanks.
>> -    default:
>> -        DBG_BUGON(1);
>> -        break;
>> +        if (!strncmp(arg, "-h", 2))
>> +            fusecfg.show_help = true;
>> +        if (!strncmp(arg, "-V", 2))
>> +            fusecfg.show_version = true;
> 
> Why you need to change this from strcmp to strncmp()?

I'll change back to `strcmp`.

> 
> 
> Besides, please change all debugging messages into:
> 
> erofs_dbg("read (%llu): size = %zu, off = %lu", ino | 0ULL, size, off);
> ..
> erofs_dbg("getxattr(%llu): name = %s, size = %zu",
>       ino | 0ULL, name, size);
> ..
> erofs_dbg("listxattr(%llu): size = %zu", ino | 0ULL, size);

Thanks.

> 
> 
> Finally, I try this commit with linux-6.1.53 source code and _libfuse2_,
> and I got several false corruptions like below:
> 
> $fssum -MACUG mnt
> stat failed for mnt//Documentation/ABI: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//Documentation/ABI: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//Documentation/.gitignore: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//LICENSES/deprecated: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//drivers/staging/most: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//drivers/staging/most: Structure needs cleaning
> 
> [xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
> $fssum -MACUG mnt
> stat failed for mnt//tools/testing/selftests/drivers/net/bonding/settings: Structure needs cleaning
> 
> I don't think it's a correct sign.  I try to debug more but
> it seems more issues here, I gave up eveuatually.

Fixed in V10. The reason is uninitialized struct in erofsfuse_lookup.

Also solve a memory leak problem in V10, now no memory leak occurs
during a over 10 mins fssum process.

> 
> Thanks,
> Gao Xiang
> 

Thanks,
Yiyan
