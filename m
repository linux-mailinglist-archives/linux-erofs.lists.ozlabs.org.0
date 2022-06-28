Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FD55C0FF
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 14:37:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXPHb5xLQz3c7H
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 22:37:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KE+ozFhq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=jnhuang95@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=KE+ozFhq;
	dkim-atps=neutral
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXPHT4PzBz3bq5
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 22:37:08 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id cv13so12447120pjb.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=10KqDo3l+oRJpK2nuoOEd70Fhsb76bpSh2Wi9097fMo=;
        b=KE+ozFhqZIqAqsS1Jh2RdtT2CWGNBxIbpoLAX4HrPe9rZNnn2xFMW9Bl54M379GyYp
         dgqARDamfcOievZuyNl7qBkLlp1MXiWbHiPuRa/MF1Z9ChSkECyDfOn6WrJBWjVZvL+/
         q2yyPgy3LQRmetxOdbj8UODUuzJnAL2d3DBxGaq/rRFCb0JCa6LOiOMxrAmCxg/ZO1Qr
         wJRKoOlcd9qArFH0/8E7F0uxyLQ/kOJHmlcFnH69Sw00Bri2w7giJBz69z9pcUYBZGej
         g5C2HFAN2BeZtvSpH7AIJOnnUOyLGUkP6MuKAG/O2/oinXoKRwZ/Bf+Ds6IaF6UJuzAX
         meVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10KqDo3l+oRJpK2nuoOEd70Fhsb76bpSh2Wi9097fMo=;
        b=bQq+ES2512no4gpHmmfRloj8wiL0Bh45bZZZEqvAxFOWhZKkTYyArnBA0+elvWJ2Nc
         LqZCYgEdk3SqOoy3AUdCu8N+Zwhlzdj69r1ktRV3dsQ+rnDAg1VhGdbMVGJd8EFJ6op2
         xCUG8AymCdIrrSxJpHLKl34Mw3A4cEXY4NnO5uzkYGGwOR4gWS6r3GUdTOI5oAI2qp62
         x3EHNLxzf1oR92R4sJU47u3dx4HzkHFYrnj89WeVcoiYfGTT8Qdv9AVWvh9YSaVxFgZJ
         KiFYExIdvO8fQCC4g/olQaWmTxCGcp4oP6cmT1aAhvxcUFi1ezJ12QXJKjmzkBy7MAzK
         tr2Q==
X-Gm-Message-State: AJIora9fFZnhN2be9mZE5GH6cT9PzDNamqkkC9Ef6xPIUF5XqkpdRP3v
	Xycxf45iq0xqQik4kjgUUjA=
X-Google-Smtp-Source: AGRyM1v1LOR56VlboBTcD6o/LS58rokcZdQDekHNJuY4yqG58mMpDMcldLcOYlL8NnkgxVKbSDTyvw==
X-Received: by 2002:a17:903:18f:b0:16a:5c43:9a85 with SMTP id z15-20020a170903018f00b0016a5c439a85mr4715326plg.122.1656419825563;
        Tue, 28 Jun 2022 05:37:05 -0700 (PDT)
Received: from [127.0.0.1] ([103.215.126.123])
        by smtp.gmail.com with ESMTPSA id g9-20020aa78749000000b005254ad7ba0fsm9582675pfo.171.2022.06.28.05.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:37:05 -0700 (PDT)
Message-ID: <6f958407-0c3c-1cd6-ced2-08bc9c267d17@gmail.com>
Date: Tue, 28 Jun 2022 20:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
To: Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
References: <cover.1656401086.git.wqu@suse.com>
 <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
From: Huang Jianan <jnhuang95@gmail.com>
In-Reply-To: <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
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
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi, wenruo,

在 2022/6/28 15:28, Qu Wenruo 写道:
> For _fs_read(), @len == 0 means we read the whole file.
> And we just pass @len == 0 to make each filesystem to handle it.
>
> In fact we have info->size() call to properly get the filesize.
>
> So we can not only call info->size() to grab the file_size for len == 0
> case, but also detect invalid @len (e.g. @len > file_size) in advance or
> truncate @len.
>
> This behavior also allows us to handle unaligned better in the incoming
> patches.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/fs.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 6de1a3eb6d5d..d992cdd6d650 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>   {
>   	struct fstype_info *info = fs_get_info(fs_type);
>   	void *buf;
> +	loff_t file_size;
>   	int ret;
>   
>   #ifdef CONFIG_LMB
> @@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
>   	}
>   #endif
>   
> -	/*
> -	 * We don't actually know how many bytes are being read, since len==0
> -	 * means read the whole file.
> -	 */
> +	ret = info->size(filename, &file_size);

I get an error when running the erofs test cases. The return value isn't 
as expected
when reading symlink file.
For symlink file, erofs_size will return the size of the symlink itself 
here.
> +	if (ret < 0) {
> +		log_err("** Unable to get file size for %s, %d **\n",
> +				filename, ret);
> +		return ret;
> +	}
> +	if (offset >= file_size) {
> +		log_err(
> +		"** Invalid offset, offset (%llu) >= file size (%llu)\n",
> +			offset, file_size);
> +		return -EINVAL;
> +
> +	}
> +	if (len == 0 || offset + len > file_size) {
> +		if (len > file_size)
> +			log_info(
> +	"** Truncate read length from %llu to %llu, as file size is %llu **\n",
> +				 len, file_size, file_size);
> +		len = file_size - offset;
Then, we will get a wrong len in the case of len==0. So I think we need 
to do something
extra with the symlink file?

Thanks,
Jianan
> +	}
>   	buf = map_sysmem(addr, len);
>   	ret = info->read(filename, buf, offset, len, actread);
>   	unmap_sysmem(buf);

