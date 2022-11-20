Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AA63174C
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Nov 2022 00:24:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NFmnJ57VMz3cJ3
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Nov 2022 10:24:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FKI9D0iE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FKI9D0iE;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NFmnB0QN4z2yQH
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Nov 2022 10:24:13 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6ED60C2E;
	Sun, 20 Nov 2022 23:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F9C433D6;
	Sun, 20 Nov 2022 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668986650;
	bh=PLoVWbBMWywVGdH+k1mh77SoCTWSY3JyRZ1NUowLdUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKI9D0iEopGXwUHxVoHbHXDKek1NjVw2INv8hJldtqVAJS+AJL8lGFyRq818stMGj
	 418KfkebSrx62lvonu0JWZz0+Hz5l6reyiCgBPMJcqtspzck0oJF8QJ2ikFownb/6c
	 YW1PeqpBDIwKR2Ay1tFK/NIaIYxs1qyCHnHTrWg/9Zm8OoS1Q0JdYWx8vn/Cgb6iD6
	 oh3lCoECiorpOLwBsu04/JIwYeW6DTFuaiELIj+GXdco5aOeUmJlhWByU21GooF3kV
	 RiyV2aBC6QKVq0dvumfzIfZ6Uo2TS25SjGMks2Okmctcr1EkaSLl0YJbQ+EZyM8rjX
	 4UjqCCClKWCJw==
Date: Mon, 21 Nov 2022 07:24:06 +0800
From: Gao Xiang <xiang@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: [PATCH] erofs-utils: dump: remove duplicate file type
Message-ID: <Y3q3FmEBnlgLOUvb@debian>
Mail-Followup-To: Weizhao Ouyang <o451686892@gmail.com>,
	linux-erofs@lists.ozlabs.org
References: <20221120040648.706871-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221120040648.706871-1-o451686892@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Nov 20, 2022 at 04:06:48AM +0000, Weizhao Ouyang wrote:
> Remove duplicate ".txt" file type distribution.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Thanks, applied.

> ---
>  dump/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index f2a09b6..93dce8b 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -37,7 +37,7 @@ static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
>  static char *file_types[] = {
>  	".txt", ".so", ".xml", ".apk",
>  	".odex", ".vdex", ".oat", ".rc",
> -	".otf", ".txt", "others",
> +	".otf", "others",
>  };
>  #define OTHERFILETYPE	ARRAY_SIZE(file_types)
>  /* (1 << FILE_MAX_SIZE_BITS)KB */
> -- 
> 2.37.2
> 
