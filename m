Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141ED9C3B46
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 10:47:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4TN1535z2yfj
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Nov 2024 20:47:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318438;
	cv=none; b=PqPu27Q0uBlV228cekV4h6ljGkpSuvleS76RVE8eT6Kn9Vwofh5em2MaVg3tI3BnsnrMrIT4342A9rDdiOS88w+iFf9YfERI8ZtopSEFJjSQIm0Vesgnt2Qm+eMh3ZwmD1BcsFvMpjidGsCNMY3aLEoLdM2NhFymd2O/RuHNEeyQlRI4Thh9XkGfRErf77vANlv+mnPmQZRLx4gPm5kmXLhFI4pV0DYkPYNJauCWin0noMFZBW6+qHPU/XJrOGpy7jX35xK8b0BQg5KgQpqBMZ5YRzzDpzfQFsnZ180/dsb18iqv6A6G5kqJX1LbeetdBJAYNGYg27+rWsoC8TB1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318438; c=relaxed/relaxed;
	bh=8mb+ah48kwAFDztCmdkFnP9jxAHQk0qBmmQt2DV13gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iO25Pjwc86hZJxrlpOkw23qfDI/UTCKFVasj8Kx3sI16YFhP8Jz/IaQo4sLDQqYsSFmMmehzEoRob2nOMwddKYhmpSeoE+J4FCURxYGkrDcQVxYpPNoRclMpKh0ftdwalZYoMh8PpVJTxumKfo2XdIQeTHG3+RUj7/qvGHuNcWdCQE+/TpcsxWuLFNIJavFCn4xxB8Rzp4fZTbVWiFYNE57UjqyzlSM1vnLr3jvpdjwcWsVOeOxyzUvZTV5q/vKubjVbfkD+5N/5IOSVyqtnGkb8PT6J+bhOHPgDx6Pz6ZRfbN2R7c4y2UBZ+InNTkprogwxnVvF98jyXs+++/G4mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WrzRDDpP; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WrzRDDpP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4TH5Pg7z2yF7
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Nov 2024 20:47:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731318428; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8mb+ah48kwAFDztCmdkFnP9jxAHQk0qBmmQt2DV13gU=;
	b=WrzRDDpPAPNiqCp213kxLA/rd/UHyb4HRMWHAKLFwYyJjZ9Un+EDxhJv0go/LahaaSYvPxc6xkLUGf1sj66b3Q5TdrSMy2Rsn0iYEumURNabLn3hwZRUR99qRbH2b32HFMKbigjrwzFXQcx3ZDqOoWbarNRr/zT/j5Wm7JHqQvw=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ8TvQF_1731318426 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 17:47:06 +0800
Message-ID: <d01ac9f5-2872-4f27-a18e-f612d3d7eb76@linux.alibaba.com>
Date: Mon, 11 Nov 2024 17:47:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: rearrange struct erofs_configure
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241111093504.3784696-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241111093504.3784696-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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



On 2024/11/11 17:35, Hongzhen Luo wrote:
> Move the content defined by the NDEBUG macro to the end.

Move the fields controlled by the NDEBUG macro to the end
to maintain a consistent layout for preceding variables.

It addresses cases where a third-party application defines
NDEBUG while erofs-utils does not (by default).  Ideally,
third-party applications should use the same macros as
erofs-utils to get a unique `struct erofs_configure`.
However, since NDEBUG enables unnecessary assertions,
restructuring the layout resolves such inconsistencies.

> The reason for doing this is to maintain a consistent layout
> for all preceding variables when a third-party application
> defines NDEBUG while erofs-utils does not (by default).
> 
> Fixes: ad6c80dc168d ("erofs-utils: lib: add erofs_get_configure()")
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>



> ---
>   include/erofs/config.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index ae366c150232..cff4ceadb7bc 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -46,10 +46,6 @@ struct erofs_configure {
>   	int c_dbg_lvl;
>   	bool c_dry_run;
>   	bool c_legacy_compress;
> -#ifndef NDEBUG
> -	bool c_random_pclusterblks;
> -	bool c_random_algorithms;
> -#endif
>   	char c_timeinherit;
>   	char c_chunkbits;
>   	bool c_inline_data;
> @@ -94,6 +90,10 @@ struct erofs_configure {
>   	char *fs_config_file;
>   	char *block_list_file;
>   #endif
> +#ifndef NDEBUG
> +	bool c_random_pclusterblks;
> +	bool c_random_algorithms;
> +#endif
>   };
>   
>   extern struct erofs_configure cfg;

