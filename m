Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0204F5066
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Nov 2019 16:58:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 478lLb6yQ7zF5ZR
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Nov 2019 02:58:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ve0ORAtE"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 478hCn04rbzF74Z
 for <linux-erofs@lists.ozlabs.org>; Sat,  9 Nov 2019 00:37:40 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id p24so4600860pfn.4
 for <linux-erofs@lists.ozlabs.org>; Fri, 08 Nov 2019 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A5N3fvVYatpPlSo7AhCeNB1KINXjvUmtciNJSE6Q5oE=;
 b=ve0ORAtEUirsVM3GvDHRmRD+WvtbK9e5qrWph83JwMTKjYSFhEiTbu0VtTHbn5iuyE
 nh+5JbP5zPn7WFmz0YKP2RJkPAcngF4B36AIfUq2EURDbXMqRBuBCmHTW7Vndp3bTmE7
 hfPUInUPCkrFGbBKZkx/LCo9Rf42486BQCq8scSUxxipqGcL+Dn87zSdGTnJGRrzwNIW
 oUOxlaxeg2RIQkEKFRheQYsDqGJOsKkr0Yw1aRYZxiMDsUX2BzgBqB43gMKP3Ce6lBMT
 /k1oRTsHd4OPsOpcmk6ok8F4j/BpguOuzXpW9/dPleRXtUVAQ57obrVXF9p5gO/m9x+w
 SvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A5N3fvVYatpPlSo7AhCeNB1KINXjvUmtciNJSE6Q5oE=;
 b=Qm4petsAsDDawBaaa9K+Tyrp/EzHGmANEvc1FNxVqfCIQ7kP8Bnzw+sQLTNnlKK1Jk
 8EL4aZK2jaEYsYsRzN+8IKJ6viRB9FH/XRmd8ehmtRAYyTJvoHsmNa043cREWvYoy8/4
 yYls6qjb3vWu10l4mSAGaamO4TH/rA9HJ+IRDKMp9YjHHJK41/qrQ16bPhzalb7IH2EH
 8rLcsmv6L14rbltx8c1f+MiLRJeemkpPh8fKsedoSCdlzhTrmBpD7rrk7O09dxjUH8lQ
 6ad8DuuB/yXpwi3CuMALIBBML0KAokssOwKdF8DYj2j2AmxcKpst0ZkmmgBHndgfSO5q
 HM0Q==
X-Gm-Message-State: APjAAAVyqLaDrGuK3+ChsK5p3XpccYzTcPnz7lPSsO7Wqh5n7Lt/hRLM
 AIzmjBQ2VG+JHveNIWxK3cQ=
X-Google-Smtp-Source: APXvYqwOvlUBHqrVG6ZRribJ4Ev8NG/418jIkxVf1xTyNAb2k3vvGy1YlGO9U2yyIDqM0yIjaZPUQA==
X-Received: by 2002:a63:1624:: with SMTP id w36mr11185792pgl.404.1573220258131; 
 Fri, 08 Nov 2019 05:37:38 -0800 (PST)
Received: from [0.0.0.0] (li1150-212.members.linode.com. [45.79.51.212])
 by smtp.gmail.com with ESMTPSA id f12sm6049659pfn.152.2019.11.08.05.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 05:37:37 -0800 (PST)
Subject: Re: [PATCH v9] erofs-utils: support calculating checksum of erofs
 blocks
To: Gao Xiang <gaoxiang25@huawei.com>,
 Pratik Shinde <pratikshinde320@gmail.com>,
 Li Guifu <bluce.liguifu@huawei.com>, Chao Yu <yuchao0@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191030025506.GA161610@architecture4>
 <20191030062809.34362-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <bdd4a875-30fb-3a0c-43b3-270a545a32cf@gmail.com>
Date: Fri, 8 Nov 2019 21:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191030062809.34362-1-gaoxiang25@huawei.com>
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



On 2019/10/30 14:28, Gao Xiang wrote:
> From: Pratik Shinde <pratikshinde320@gmail.com>
> 
> Added code for calculating crc of erofs blocks (4K size).
> For now it calculates checksum of first block. but it can
> be modified to calculate crc for any no. of blocks.
> 
> Note that the first 1024 bytes are not checksumed to allow
> for the installation of x86 boot sectors and other oddities.
> 
> Fill 'feature_compat' field of erofs_super_block so that it
> can be used on kernel side. also fixing one typo.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> 
It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
