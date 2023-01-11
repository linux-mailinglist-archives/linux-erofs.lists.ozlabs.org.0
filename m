Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4F6656F9
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 10:09:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NsMM62FG3z3cDT
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Jan 2023 20:09:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tR+pQJ4j;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tR+pQJ4j;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NsMM14r9pz3bfy
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 20:09:31 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so16118691pls.6
        for <linux-erofs@lists.ozlabs.org>; Wed, 11 Jan 2023 01:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJOauMbSW88GAjj4ZRlRlEslA3B+Klpw8vA3Ba7wPBA=;
        b=tR+pQJ4j0gQnCw8f29LxFrFjA7OGKau2jboVV/pfVFTuMzXEeyrYGRceE8+RYXPma7
         ToNgrI248CQwo+OP5WdK/Uj5D5/QnKrxXE4+ppVotdcWcXWcoftx9Y7fcFa2ezQ7GLYh
         2IJeGVu3NgyQAYWxTN/+C823ekjZ68cHGoUdWzuoVC1zXWVWQpb4I9ngJHl7Z3D3aMxo
         InyT78bLH4Jc7TokCjB1AdcdW98HBGf4tCrEXR9JhGi01LYSBnUoT6CKzDkMeAQUpBD6
         bYR7IV5toANf4KVASBydtsFCYO/RrHDqLEaL7f77DtJ4UnmMOhR6qN8qkgso16jVuy9g
         lmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JJOauMbSW88GAjj4ZRlRlEslA3B+Klpw8vA3Ba7wPBA=;
        b=mu4FXoUpLW/S/QtokOsmRQjMJko3efCJihKmNOJ50uPiACGqEsarWrzAuSHSw2AetR
         HpVqyYNOoPw1jkJDc/rcxLBWPqAsgBOBnse2u2rkgtiw88a62gTHkE3cB0ufBo63aTX7
         wh3MavnEBIxk4CP/RCaFlRpAlphrsfEILy65FkodnKxcN9zBAcxaUGEqdv0lQbTpoA8C
         xK/GHMA8Nnv+yNjHi89+Y5jqaAQSxdtmafw4b/oHmPoebN9TPWDJWGJjgzPaMP/FN8VX
         UW6iAEFBzLauiUvhzy02At8fZo1UbEYF61buHwZAFo2IIGWbvo/BFla6Kpyrz3Vg3YCj
         STcA==
X-Gm-Message-State: AFqh2kqqa0HPeookAizKMPpLdNwXLx2d+6HPvca5rAfg2dMuEsI+jDTV
	Wearh3tAwmiK4+U0zWwC0N9snQ==
X-Google-Smtp-Source: AMrXdXuhPGvgLLjvLZV7aDaj6Q8f8017XpxGS2VV6jXwhCqCB4P1NCUnZ+ZQO0WN9V2Rnnz3qnKJRg==
X-Received: by 2002:a17:902:ebc6:b0:194:4fb3:65a6 with SMTP id p6-20020a170902ebc600b001944fb365a6mr588075plg.18.1673428168866;
        Wed, 11 Jan 2023 01:09:28 -0800 (PST)
Received: from [10.3.144.50] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b00191292875desm9574618plf.279.2023.01.11.01.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:09:28 -0800 (PST)
Message-ID: <aef857c3-a1e1-d39e-c8c7-43cad1a48864@bytedance.com>
Date: Wed, 11 Jan 2023 17:09:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [External] [PATCH 2/2] erofs: clean up parsing of fscache related
 options
To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20230111081547.126322-1-jefflexu@linux.alibaba.com>
 <20230111081547.126322-3-jefflexu@linux.alibaba.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20230111081547.126322-3-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2023/1/11 16:15, Jingbo Xu 写道:
> ... to avoid the mess of conditional preprocessing as we are continually
> adding fscache related mount options.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

Thanks.
> ---
>   fs/erofs/super.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 481788c24a68..626a615dafc2 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -577,26 +577,25 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		}
>   		++ctx->devs->extra_devices;
>   		break;
> -	case Opt_fsid:
>   #ifdef CONFIG_EROFS_FS_ONDEMAND
> +	case Opt_fsid:
>   		kfree(ctx->fsid);
>   		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>   		if (!ctx->fsid)
>   			return -ENOMEM;
> -#else
> -		errorfc(fc, "fsid option not supported");
> -#endif
>   		break;
>   	case Opt_domain_id:
> -#ifdef CONFIG_EROFS_FS_ONDEMAND
>   		kfree(ctx->domain_id);
>   		ctx->domain_id = kstrdup(param->string, GFP_KERNEL);
>   		if (!ctx->domain_id)
>   			return -ENOMEM;
> +		break;
>   #else
> -		errorfc(fc, "domain_id option not supported");
> -#endif
> +	case Opt_fsid:
> +	case Opt_domain_id:
> +		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
>   		break;
> +#endif
>   	default:
>   		return -ENOPARAM;
>   	}
