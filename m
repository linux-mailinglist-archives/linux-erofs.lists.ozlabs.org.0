Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043B6DBFD3
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:27:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvWZQ26m5z3cf0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:27:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvWZK3RQBz3cd5
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:27:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vfd3oBk_1681043218;
Received: from 30.213.177.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfd3oBk_1681043218)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 20:27:00 +0800
Message-ID: <5da6f9fe-a989-8256-8eaf-61381342e684@linux.alibaba.com>
Date: Sun, 9 Apr 2023 20:26:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/5] erofs-utils: mkfs: drop dead code in -z parsing
To: =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
 <df945a64dbab234faec152a2fca75747f724d0c2.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <df945a64dbab234faec152a2fca75747f724d0c2.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/9 19:56, Ahelenia Ziemiańska wrote:
> -z is specified as "z:".
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   mkfs/main.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 94f51df..d20147c 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -276,11 +276,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   				  long_options, NULL)) != -1) {
>   		switch (opt) {
>   		case 'z':
> -			if (!optarg) {
> -				cfg.c_compr_alg[0] = "(default)";
> -				cfg.c_compr_level[0] = -1;
> -				break;
> -			}
>   			i = mkfs_parse_compress_algs(optarg);
>   			if (i)
>   				return i;
