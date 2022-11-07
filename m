Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90261F65A
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Nov 2022 15:42:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N5Ypq5v4cz3bbB
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 01:42:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NUw6dzVi;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=NUw6dzVi;
	dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N5Yph54DKz3bbB
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 01:42:04 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so10622572pgc.9
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Nov 2022 06:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpaUCO78J+XfOOB4UTMko2tm5ZNs2acSxi/1vpzRt5Q=;
        b=NUw6dzVijAV7U+uWIcyNo1dhTOCkGgatzrmZfs8T16BjAqgcGOeqDJlpV6HrRwpVlj
         Yvz84EIB276eXUgOK8rY1f2s6JToVHzCz9ch79YaZ1Sl1sJTvVafQCjpgW+6KpxueNj2
         kIF49EuMfLvcG7BvlEiM1ncxEtfliNoXFGjXsCQ6JWrX25WerBI4OL3wOLpfRmwgAEM9
         PPv6euiDUoir+NERawnA8B7z1b4qh0z+WFKg0vQr6CdWjpjgyfgEqPc2/fiCqwX5Q7Ls
         n/WO56fEGwDALDm2RLhvWLIggzXRKv6jp5pkrzYzoswPdPjb5hOt7uCa89O+lpQcr7Aw
         Qrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpaUCO78J+XfOOB4UTMko2tm5ZNs2acSxi/1vpzRt5Q=;
        b=H8tEsz41vkc3yrEISYp+BceU6Z3iR2YWiiGT3fkieTw1nqQBtXVWuh5B679mJ2kZvT
         c6CmxaIhokoYxADfokOoMV69L0MeasFGF3ORQLhm7A6GCBF6Yu9TjStxeK9IRe2CFzo1
         2Fk6Ii97fP0aV9BdufUk/8gi7ny4KRcIvgwxIgHysufwAoPsZmE/hgXD2KAbq+DtUej8
         8AhAARdFC8uebgYnfaEJTbts3jFX1ecMsT+1yFcU8/fQQXIC5ap6nKb86LE89LTj8iNI
         GABb03PfbA8t2OhD95d043jRzNUdiLxLzUhnTyHa1dESJPvxq6D9x0MpTpADpbls31r9
         oOEg==
X-Gm-Message-State: ACrzQf0vHt4w9ZkBjiFgUkMjsyZ/8grS0c8Ru6xlduIiqdWaYlcOZuKr
	5+fPe4IIY12mG0E4bptY8DcFpg==
X-Google-Smtp-Source: AMsMyM5IN215GF0/pokM5ghYLA//82M1Y8wJP7921bgAqP2H20MCo2o1KLkwVkaU/Ty3T+/dxkHaMQ==
X-Received: by 2002:a05:6a00:140f:b0:56e:1190:e731 with SMTP id l15-20020a056a00140f00b0056e1190e731mr28656854pfu.39.1667832121594;
        Mon, 07 Nov 2022 06:42:01 -0800 (PST)
Received: from [10.4.186.187] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y13-20020a63fa0d000000b00460c67afbd5sm4294802pgh.7.2022.11.07.06.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:42:01 -0800 (PST)
Message-ID: <b66ad97f-9d7e-0453-85e1-3b45ff14da6a@bytedance.com>
Date: Mon, 7 Nov 2022 22:41:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] [PATCH 1/2] erofs: put metabuf in error path in
 fscache mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/11/4 13:40, Jingbo Xu 写道:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..83559008bfa8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -287,8 +287,10 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>   			return PTR_ERR(src);
>   
>   		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src + offset, size, &iter) != size)
> +		if (copy_to_iter(src + offset, size, &iter) != size) {
> +			erofs_put_metabuf(&buf);
>   			return -EFAULT;
> +		}
>   		iov_iter_zero(PAGE_SIZE - size, &iter);
>   		erofs_put_metabuf(&buf);
>   		return PAGE_SIZE;
