Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B024755D93
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 09:54:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4DqV0YbLz2yGq
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 17:53:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4DqN2Xf8z2yD4
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Jul 2023 17:53:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VnYYE5w_1689580421;
Received: from 30.221.156.201(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnYYE5w_1689580421)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 15:53:42 +0800
Message-ID: <bd4657ff-dea8-9b37-625f-c5ecf6bd5518@linux.alibaba.com>
Date: Mon, 17 Jul 2023 15:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] erofs-utils: lib: support GNUTYPE_LONGNAME for tarerofs
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230717073531.43203-1-hsiangkao@linux.alibaba.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230717073531.43203-1-hsiangkao@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 7/17/23 3:35 PM, Gao Xiang wrote:
> The 'L' entry is present in a header for a series of 1 or more 512-byte
> tar blocks that hold just the filename for a file or directory with a
> name over 100 chars.
> 
> Following that series is another header block, in the traditional form:
>    A header with type '0' (regular file) or '5' (directory), followed by
>    the appropriate number of data blocks with the entry data.
> 
> In the header for this series, the name will be truncated to the 1st 100
> characters of the actual name.
> 
> Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/tar.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index 8edfe75..b62e562 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -570,6 +570,14 @@ restart:
>  		if (ret)
>  			goto out;
>  		goto restart;
> +	} else if (th.typeflag == 'L') {
> +		free(eh.path);
> +		eh.path = malloc(st.st_size + 1);
> +		if (st.st_size != erofs_read_from_fd(tar->fd, eh.path,
> +						     st.st_size))
> +			goto invalid_tar;
> +		eh.path[st.st_size] = '\0';
> +		goto restart;
>  	} else if (th.typeflag == 'K') {
>  		free(eh.link);
>  		eh.link = malloc(st.st_size + 1);

LGTM.

Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo
