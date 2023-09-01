Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DE7900CE
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Sep 2023 18:39:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RckJk3xm8z3c26
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Sep 2023 02:39:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RckJd5sKqz2yxX
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Sep 2023 02:39:27 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vr6RS8u_1693586358;
Received: from 30.25.203.111(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vr6RS8u_1693586358)
          by smtp.aliyun-inc.com;
          Sat, 02 Sep 2023 00:39:22 +0800
Message-ID: <af6f73f1-5534-b29e-6643-a6af7e5bb144@linux.alibaba.com>
Date: Sat, 2 Sep 2023 00:39:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v8] erofs-utils: add support for fuse 2/3 lowlevel API
To: Li Yiyan <lyy0627@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230901160951.697085-1-lyy0627@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230901160951.697085-1-lyy0627@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2023/9/2 00:09, Li Yiyan wrote:
> Add support for the fuse low-level API in erofsfuse, proven correct in> 22 test cases. Lowlevel API offers improved performance compared to the
> high-level API, while maintaining compatibility with fuse version
> 2(>=2.6) and 3 (>=3.0).

Support FUSE low-level APIs for erofsfuse.   Lowlevel APIs offer
improved performance compared to the previous high-level APIs,
while maintaining compatibility with libfuse version 2(>=2.6)
and 3 (>=3.0).

> 
> Dataset: linux 5.15
> Compression algorithm: -z4hc,12

Compression algorithm: lz4hc, 12


> Additional options: -T0 -C16384
> Test options: --warmup 3 -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1"
> 
> Evaluation result (highlevel->lowlevel avg time):
> 	- Sequence metadata: 777.3 ms->180.9 ms
> 	- Sequence data: 3.282 s->818.1 ms
> 	- Random metadata: 1.571 s->928.3 ms
> 	- Random data: 2.461 s->597.8 ms
> 
> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
> ---

...

> +
> +static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
>   {
> -	struct erofsfuse_dir_context *fusectx = (void *)ctx;
> -	struct stat st = {0};
> +	size_t size = 0;
>   	char dname[EROFS_NAME_LEN + 1];
> +	struct erofsfuse_readdir_context *readdir_ctx = (void *)ctx;
> +
> +	if (readdir_ctx->offset < readdir_ctx->start_off) {
> +		readdir_ctx->offset +=
> +			ctx->de_namelen + sizeof(struct erofs_dirent);
> +		return 0;
> +	}
>   
>   	strncpy(dname, ctx->dname, ctx->de_namelen);
>   	dname[ctx->de_namelen] = '\0';
> -	st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;

here << 12 means S_SHIFT.

> -	fusectx->filler(fusectx->buf, dname, &st, 0);
> +	readdir_ctx->offset += ctx->de_namelen + sizeof(struct erofs_dirent);
> +
> +	if (!readdir_ctx->is_plus) { /* fuse 3 still use non-plus readdir */
> +		struct stat st = { 0 };
> +
> +		st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);

I'm afriad that is incorrect.  Maybe we need a erofs_ftype_to_umode()
helper then.

> +		st.st_ino = ctx->de_nid;
> +		size = fuse_add_direntry(readdir_ctx->req, readdir_ctx->buf,
> +					 readdir_ctx->buf_size, dname, &st,
> +					 readdir_ctx->offset);
> +	} else {
> +#if FUSE_MAJOR_VERSION >= 3
> +		struct fuse_entry_param param;

I think here you could define as
		struct fuse_entry_param param = {
			.ino = erofsfuse_to_ino(ctx->de_nid),
			.attr.st_ino = ctx->de_nid,
			.attr.st_mode = erofs_ftype_to_umode(ctx->de_ftype),
		};
to avoid uninitialized fields.


> +
> +		param.ino = erofsfuse_to_ino(ctx->de_nid);
> +		param.generation = 0;
> +		param.attr.st_ino = ctx->de_nid;
> +		param.attr.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);

ditto.


Otherwise it looks good to me generally.

Thanks,
Gao Xiang
