Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB2EE514
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Nov 2019 17:49:11 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 476JfY0skczF412
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Nov 2019 03:49:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="S8/OTEMf"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476JT20V9pzF406
 for <linux-erofs@lists.ozlabs.org>; Tue,  5 Nov 2019 03:40:53 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so7782971pll.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 04 Nov 2019 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HO6E5b2tsFcaRb0s/J4XLrYYq8Z+HR0AY5Z5nLqwomM=;
 b=S8/OTEMfUx5jIqQI9/F9opacKcE/fMRZN/Amo3xSKUodBE0QQ6BhpvyLMSVY81zey8
 JNgbGJIIWmarpNfj9PoL839t7xG/3nYVsQ8GTSbfIe38Nw4y6Q34yY1TMu+3xLlyojWK
 8xy7360TTwGg8BSTiVfMlVqIKjJCndkezIc4sunxPx/qrtEq03BNpcYxrWvwe0VXnfqf
 qkmd9m3sDzrtvCknOofxqMW3eNba8kq6vXvBtkqA4NCQP2lOmJP5N/b5LUBaCz5FxYa7
 ifNoX9oEA585hNH1FfAUz/tGBrQDtSbSKwYAO00ynNE72daNCqeCmzS0+8u4ik1viagq
 wbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HO6E5b2tsFcaRb0s/J4XLrYYq8Z+HR0AY5Z5nLqwomM=;
 b=pSPfILaP8OEA+XJGRY2B3DnJHm1UNGjbKAb4aT5wQrfaX6rk26CG80tc/rxBL85YaN
 PTLs3cmo/CmihbYI3oDJdRtrjNYFK0oDieeiyBHF0lqFMpv9wxWypyCIKM9eLGOsjnGD
 0OH+NJNSf4DtGpO+HCF+SMjWCzZzlzgWVhT4pvCc5tatMgaHBpDB87pJqS044axmDB0U
 CUEpy0ze8LOsuyWrfLDqnLA49rHCfARGFn2jqZ01d7vsnP5uQZRebiOvjai/UeldkZti
 Z4yPyVpnBPpi0wKciPfABmedZe0b9o2K6du9GQYlatJMpFHdAZJjEW/VYyyRpuEc8LkY
 GU8A==
X-Gm-Message-State: APjAAAW3zFi/mJVe6Q8t+koUA9zQaqLuYXotQ3Sep6lzODzN6iR9qxsq
 Hf5ewHkSziYQLYe7kljolj8=
X-Google-Smtp-Source: APXvYqw5UMgxCUUzqv5zX+DqPuBeRA1Oz/fr9h66kzwh/CzimjuWzDyU3nwXbYOFC/P1tNFKIXUhxg==
X-Received: by 2002:a17:902:9691:: with SMTP id
 n17mr22839435plp.12.1572885649392; 
 Mon, 04 Nov 2019 08:40:49 -0800 (PST)
Received: from [0.0.0.0] (li1150-212.members.linode.com. [45.79.51.212])
 by smtp.gmail.com with ESMTPSA id z7sm10168203pgk.10.2019.11.04.08.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 08:40:48 -0800 (PST)
Subject: Re: [PATCH v2] erofs-utils: add manual for mkfs.erofs
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191103153055.11471-1-hsiangkao@aol.com>
 <20191104072817.7936-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <52e5b1f0-ad58-5664-e895-0b6566308509@gmail.com>
Date: Tue, 5 Nov 2019 00:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191104072817.7936-1-hsiangkao@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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


On 2019/11/4 15:28, Gao Xiang wrote:
> This patch adds mkfs.erofs manpage, which is a requirement of
> a debian binary package (See Debian Policy Manual section 12.1 [1].)
> 
> [1] https://www.debian.org/doc/debian-policy/ch-docs.html#manual-pages
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
