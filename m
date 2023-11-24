Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BE7F6B08
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 04:47:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sc1Bg61Dxz3cDy
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Nov 2023 14:47:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sc1BY053Kz2xKQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Nov 2023 14:47:00 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vx02BCX_1700797613;
Received: from 30.97.48.234(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vx02BCX_1700797613)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 11:46:54 +0800
Message-ID: <6b899bdb-23c5-50bf-6ba6-ab9d6261fafe@linux.alibaba.com>
Date: Fri, 24 Nov 2023 11:46:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] erofs-utils: tests: fix build warning in
 test_LZ4_compress_HC_destSize
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20231124033629.26035-1-zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231124033629.26035-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2023/11/24 11:36, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> badlz4.c:72:58: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘long unsigned int’ [-Wformat=]
>     printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
>                                                           ~^
>                                                           %ld
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   tests/src/badlz4.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/src/badlz4.c b/tests/src/badlz4.c
> index f2f1f05..2a4a908 100644
> --- a/tests/src/badlz4.c
> +++ b/tests/src/badlz4.c
> @@ -60,17 +60,18 @@ int test_LZ4_compress_HC_destSize(int inlen)
>   	char buf[1642496];
>   	int SrcSize = inlen;
>   	char dst[4116];
> +	int DstSize = sizeof(dst);
>   	int compressed;
>   
>   	void *ctx = LZ4_createStreamHC();
>   
>   	memset(buf, 0, inlen);
>   	compressed = LZ4_compress_HC_destSize(ctx, buf, dst, &SrcSize,
> -					      sizeof(dst), 1);
> +					      DstSize, 1);
>   	LZ4_freeStreamHC(ctx);
> -	if (SrcSize <= sizeof(dst)) {
> +	if (SrcSize <= DstSize) {
>   		printf("test LZ4_compress_HC_destSize(%d) error (%d < %d)\n",
> -		       inlen, SrcSize, sizeof(dst));

Could we just use printf(...., (int)sizeof(dst)); instead?

Thanks,
Gao Xiang

> +		       inlen, SrcSize, DstSize);
>   		return 1;
>   	}
>   	printf("test LZ4_compress_HC_destSize(%d) OK\n", inlen);
