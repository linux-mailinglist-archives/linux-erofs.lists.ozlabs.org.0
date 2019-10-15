Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546BD7A90
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2019 17:53:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46t0MR2t31zDr1g
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Oct 2019 02:53:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tt1VTcLU"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46t0MJ2vmzzDqt3
 for <linux-erofs@lists.ozlabs.org>; Wed, 16 Oct 2019 02:53:15 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id y22so12757050pfr.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2019 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=19a7QqLXO37VPcuNzrEa5Mxa0JH8jBlvNahxO5gAkcE=;
 b=Tt1VTcLUP5GbT0WnSd6+xc2qk4DOLXNjFjWbYnmZ/EpMa0fybVjTUufp9tkLmpXFvW
 yMGuFhNKqRMAFs3WogkIMUDtWwRRFa5+HWI4k25FCAtGG799bHpWXHSOjtbmfyWI1xBw
 ib6nI+ck2TmCe77XtFlHUdOa/HyKs33jOkEgcn2ecVzAYSYbOCHLhvTOh+7QCilSmkg3
 fUbgkxDyuoZu8ymxP7TcdLaFlQxluB7v4WslGZLL8MNeDAUrIcUaKNVgo6UloAv80Mnn
 vsrSSpoXPRBUBtNw4eD4bhpiR0xmeEgbRR0+3jyLwa5pR7Z1e9K1xx4T6LSf2e0/lOpj
 LkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=19a7QqLXO37VPcuNzrEa5Mxa0JH8jBlvNahxO5gAkcE=;
 b=tOako2+gpOZDnH6mPVkERGxSmIKZIWWE5fF3B/e1VoU+1sng8F3ghcYS4dRfXL2Pw9
 CsWhrXqg+avgG13T31tePIV7DXcWfqtomXK0eQgWvWuiOFgYj8jp6ThCD2Cvr/kwX/5O
 16T9Ln8gebOq13+SepO42JMtR57ydlmfW2LMeOHUnrNp9PWs7vMYvYq/WeRnX9xtXSnW
 C5q6WmDTQ88Gkm6strc2pjvePS4A8IY4NNcx5mDpQ1kA5XEyHMPzFHUD+IoApYlUZcuT
 2j+UNyjZ6JluGMD1oDtwkKngKwsooWAq00mCKszsThPY2dvxo0H3KbcRSB4IPrWwFJuW
 eodQ==
X-Gm-Message-State: APjAAAUPYKh70EXi/mgSUbZ5A7zsluHAazQsn0RY0kvRFYmvYHcjROyn
 vNsbu5BJNZyzPIt2uUZSBsw=
X-Google-Smtp-Source: APXvYqxgL8gXFT7suvjMjSUGH11uFsPrxXcFZ+WSuD+oYtMDB8j77veZ6ivDzu1Gg0W2FNvWuYYoMQ==
X-Received: by 2002:a62:5cc7:: with SMTP id
 q190mr40047337pfb.146.1571154794336; 
 Tue, 15 Oct 2019 08:53:14 -0700 (PDT)
Received: from [0.0.0.0] (li2016-34.members.linode.com. [172.105.123.34])
 by smtp.gmail.com with ESMTPSA id x20sm24698752pfp.120.2019.10.15.08.53.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Oct 2019 08:53:13 -0700 (PDT)
Subject: Re: [PATCH v3] erofs-utils: use cmpsgn(x, y) for standardized large
 value comparsion
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <ef338ece-ea98-d4f9-18e3-db5d1e163995@gmail.com>
 <20191015155025.13215-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <351025ef-dd71-5af9-48ec-8a2ea6b8e045@gmail.com>
Date: Tue, 15 Oct 2019 23:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015155025.13215-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


> Previously, roundup(bb->buffers.off % EROFS_BLKSIZ, alignsize)
> + incr + extrasize is an unsigned 64bit value and sgn(x) didn't
> work properly. Fix it.
> 
> Fixes: b0ca535297b6 ("erofs-utils: support 64-bit internal buffer cache")
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---

It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
