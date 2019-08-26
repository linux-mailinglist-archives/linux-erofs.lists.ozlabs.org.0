Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1329D324
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 17:40:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HGRp3jDczDqjW
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 01:40:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="k7+oImz0"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HGQG1w6TzDqhD
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 01:39:17 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id y9so11663024pfl.4
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2019 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=c1Eip0w9mvXAgEAoLppCWk1qdmdHf377p7DiyqTqquk=;
 b=k7+oImz0X8C0Ps1LFhYPe4BcSZOTqemEUQ5RaxNUsmOdkVwjSXh+EE4XuShmLfT0Qf
 qLRLDAzM+WKr0wwRJvzicXcNtsbNHWI+h1RAvNXiBfzeh5sXQRKLl35Rls5on0fauaYi
 v76PWGlnZZEhYeo/Vds63TyIytKNspWz5jYB9FYiVmRfuEw1rvZesBrmHLcCH8ZRTs1W
 VKYTdpC8Fs8Odw2MzSf5y50EtZ/t9/86Z+7O81TAOf5wLiR84COMNtiHG1+IGxfQ3lTl
 8mz2OMCQrj/KF2ZmwEwPmjFszqthP29pIgMiJLLzESa7PdS2icwtUmyoz0+EmEwAG4rI
 XDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=c1Eip0w9mvXAgEAoLppCWk1qdmdHf377p7DiyqTqquk=;
 b=e5UkdV++iYITkMujKEF+MvgpRY0ASeqhwcqGHWVvShKx9Qrj/8eDBAZWPqjpwt/3QD
 SMb7c2dtMuA9TTCJp94rDkgMXkOz0tHrfxzH11Oo6GH+FrgaBnRAAPphbRfd1yN7HXX+
 1Q2Tdfy54YmPA8rbHtgR5iMWZTAEvdTXjhnMG0U6il6iTuTvFj7g+840aLb4aRlnyagA
 89gzTCIGrRY6iVIED49S3i9FuGfjfyZR6cKJdBxhgDyssGKVsFwrFHY0L++nm4v/DJm5
 AqNuRtpG+Wopp8LUua3N2D7DJixm9Is4QW6vppa4HNcsaqTC2dQMx2V2fKhwfW3XatfR
 s6fQ==
X-Gm-Message-State: APjAAAWxLVFz5ygWiVK+5tB3/g7vcLfxRokcKjtQhAXu9kTR8an2lUFA
 rp0+4G2FfgOsw4e6Y2RGU2JZTyWIDfg=
X-Google-Smtp-Source: APXvYqyG1yEdkAOVL7q8hvTOKdbJwmaJ/MhoddrrRUWOP9nuq5t5D9ZaiJRkvy3lfIXIy9yGWLnWbw==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr16510208pgk.297.1566833955079; 
 Mon, 26 Aug 2019 08:39:15 -0700 (PDT)
Received: from [0.0.0.0] (li104-163.members.linode.com. [72.14.189.163])
 by smtp.gmail.com with ESMTPSA id h17sm14013607pfo.24.2019.08.26.08.39.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 08:39:14 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: fix up "-E legacy-compress" option
To: Gao Xiang <hsiangkao@aol.com>, bluce.liguifu@huawei.com,
 linux-erofs@lists.ozlabs.org
References: <20190826153230.14892-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <d2f59966-8e5e-0eff-3d2c-4c07c022c58c@gmail.com>
Date: Mon, 26 Aug 2019 23:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190826153230.14892-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2019/8/26 23:32, Gao Xiang via Linux-erofs 写道:
> "-E legacy-compress" isn't parsed properly, fix it now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>   mkfs/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
