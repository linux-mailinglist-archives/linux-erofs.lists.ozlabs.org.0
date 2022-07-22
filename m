Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B860B57DA21
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 08:16:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lpzhb6tdtz3c7H
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 16:15:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 306 seconds by postgrey-1.36 at boromir; Fri, 22 Jul 2022 16:15:51 AEST
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LpzhR643cz307C
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 16:15:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4..rj_1658470235;
Received: from 30.227.66.15(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VK4..rj_1658470235)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 14:10:36 +0800
Message-ID: <528c0378-90c2-8bcd-032c-837fc82bb321@linux.alibaba.com>
Date: Fri, 22 Jul 2022 14:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] erofs: get rid of the leftover PAGE_SIZE in dir.c
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org
References: <20220619150940.121005-1-hsiangkao@linux.alibaba.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220619150940.121005-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 6/19/22 11:09 PM, Gao Xiang wrote:
> Convert the last hardcoded PAGE_SIZEs of uncompressed cases.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
> index 18e59821c597..723f5223a4fa 100644
> --- a/fs/erofs/dir.c
> +++ b/fs/erofs/dir.c
> @@ -90,7 +90,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  
>  		nameoff = le16_to_cpu(de->nameoff);
>  		if (nameoff < sizeof(struct erofs_dirent) ||
> -		    nameoff >= PAGE_SIZE) {
> +		    nameoff >= EROFS_BLKSIZ) {
>  			erofs_err(dir->i_sb,
>  				  "invalid de[0].nameoff %u @ nid %llu",
>  				  nameoff, EROFS_I(dir)->nid);
> @@ -99,7 +99,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		}
>  
>  		maxsize = min_t(unsigned int,
> -				dirsize - ctx->pos + ofs, PAGE_SIZE);
> +				dirsize - ctx->pos + ofs, EROFS_BLKSIZ);
>  
>  		/* search dirents at the arbitrary position */
>  		if (initial) {

LGTM.

Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jeffle
