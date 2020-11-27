Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DA2C615A
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 10:08:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cj80w5BJ8zDrgJ
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 20:08:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=OIf9q7Nl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OIf9q7Nl; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cj80l5GtrzDrBk
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 20:07:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606468067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOyp5qrAuEK5VI28blGnE0Zm0JfJdklUohIkT1cALGc=;
 b=OIf9q7NlaiTWpNaB++N9kMoYnjP/mnQxJLbE8Axp8FRrplFz1AVgseHvD9kunO617wKtJ5
 zSCf3g7hxZfgRiBVNjxlAm0POV2iZEHNAUjUE+75a9ysQf1M1R4JQg2xz7dtmCdP/26bWY
 XzKc3KPRNq6aSe4QTM9LEdcZ5nErtBQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606468067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOyp5qrAuEK5VI28blGnE0Zm0JfJdklUohIkT1cALGc=;
 b=OIf9q7NlaiTWpNaB++N9kMoYnjP/mnQxJLbE8Axp8FRrplFz1AVgseHvD9kunO617wKtJ5
 zSCf3g7hxZfgRiBVNjxlAm0POV2iZEHNAUjUE+75a9ysQf1M1R4JQg2xz7dtmCdP/26bWY
 XzKc3KPRNq6aSe4QTM9LEdcZ5nErtBQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-uL_WVOo5M-a7qwWHCvNYxA-1; Fri, 27 Nov 2020 04:07:45 -0500
X-MC-Unique: uL_WVOo5M-a7qwWHCvNYxA-1
Received: by mail-pg1-f199.google.com with SMTP id b35so3354863pgl.8
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 01:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=LOyp5qrAuEK5VI28blGnE0Zm0JfJdklUohIkT1cALGc=;
 b=ttkTLbgB6IAL/+gVh4LdL9n8X/+bNQmqNOOkuei8nHSIgGgndNsxl1YE2aovDuh2gD
 JvDeZHGtNO1lHTRmw354vOrXTqqIUCr97iYoORWZK9CCCiFjanl3ooNsGn5im0oK6g3x
 tK8OCh44tFRnWI39av7h5FZsc2pFcysdILADn6X6jMDcx4fUkVfVnPMWMdnh5xzw0YAq
 Mzw1RMMMg1VfAgfA6E2OZv8goBls182HtmoyUKbv2DNyQ2MCenN2mwDq6oyaGrotxNhW
 qcbVHKFlyLj0Ha2qJCLFI6xJb7iTbtiBEyChwg1rrARl4iKh4z+Rp6uoYiPksi9j4vJ3
 Vq3w==
X-Gm-Message-State: AOAM533R4n6sOpMrqPLyfPErdJYC3EErZHNbQ3ncPYNRiooU8oT4oHmf
 rBEfU5QzDWFjWSVMduzzbPN4v57aJSJR3puxbWsNWEkynXLaxTQ38A/++Fjb7fXQQPzRGQEY7xs
 tAdV12PpJf8ZKcHVWQOzsQ+Ju
X-Received: by 2002:a17:90b:11d3:: with SMTP id
 gv19mr8728580pjb.232.1606468064184; 
 Fri, 27 Nov 2020 01:07:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAgeqjTGXl3qforlMQC/cegoFf1R9dr2+lxh2o7Ama2MzmDw2MR1H0juwd6U3RjJrjNeZZIg==
X-Received: by 2002:a17:90b:11d3:: with SMTP id
 gv19mr8728558pjb.232.1606468063939; 
 Fri, 27 Nov 2020 01:07:43 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x24sm6834852pgh.17.2020.11.27.01.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2020 01:07:43 -0800 (PST)
Date: Fri, 27 Nov 2020 17:07:32 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] erofs-utils: fix random data in shared xattrs
Message-ID: <20201127090732.GA598572@xiangao.remote.csb>
References: <20201127083334.32738-1-huangjianan@oppo.com>
MIME-Version: 1.0
In-Reply-To: <20201127083334.32738-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Nov 27, 2020 at 04:33:34PM +0800, Huang Jianan wrote:
> There will be holes between xattr entry after EROFS_XATTR_ALIGN, so
> we should clear shared xattrs buff to avoid random data.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---

Looks good,
Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

It's mandatory for reproducable build. Also, need to
fix the bufops out-of-bound access as well (Will check
this weekend).

Thanks,
Gao Xiang

>  lib/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 1ce3fb3..f9ec78c 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -547,7 +547,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
>         if (!shared_xattrs_size)
>                 goto out;
> 
> -       buf = malloc(shared_xattrs_size);
> +       buf = calloc(1, shared_xattrs_size);
>         if (!buf)
>                 return -ENOMEM;
> 
> --
> 2.25.1
> 
> ________________________________
> OPPO
> 
> 本电子邮件及其附件含有OPPO公司的保密信息，仅限于邮件指明的收件人使用（包含个人及群组）。禁止任何人在未经授权的情况下以任何形式使用。如果您错收了本邮件，请立即以电子邮件通知发件人并删除本邮件及其附件。
> 
> This e-mail and its attachments contain confidential information from OPPO, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!
> 

