Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD927B5160
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 17:24:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Xn2l4cWbzF3FC
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2019 01:24:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="m6sH57Z7"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Xms20rdBzF3yf
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Sep 2019 01:15:50 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id y5so2356781pfo.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2019 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=FaX3DMcg1yrSh/q0LJ73RpC4v9xlfUU0XPfh+BYOLXo=;
 b=m6sH57Z7Skoammsge4kdrUgu9eJJHhiVHxNlCVMFvGEqJypKN7N0Z1NsmQKvqJhMPl
 77pRbxRAKrRAu2IKUL8wxPDPbxsOrYFnxc3VllY49s2AnbYuQ1p9/jfQhONLcfHQFFNz
 Px691W0TXzOqoGIGUAEhWgSWwtbECjQYJZ379F1PHQTrRbPfUDCGSHZC0+d1ndUTZTth
 2OGSs1IvTGJ9xi1r78geZ2U8N9r/DmgczNoNDocu4e36t8Nak6C05g+4xFe8C+v6f9bv
 NvzuL7fR3uueyQENBrzPpVKGEhvul3uLuZh4nF7Ygilj2sWh8BaVJlEEDqkpMo7Cddvf
 P8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=FaX3DMcg1yrSh/q0LJ73RpC4v9xlfUU0XPfh+BYOLXo=;
 b=AT12eyJ+dDoLMsToP0UFS73wUkN0Fq7OrALlH8MOOY4FuWcahMGy8T9wScFknYJEDw
 2oAslspZM7X4EC8dOpThTx35uhPD3fKG70PP9iS4tQ5f12yvx7rdUnq+4FCDWyZxFgPD
 LgJ27D5IRCNsDCaSj+ZMXyc6bI1EU+BpfsPVy6be/tnxmqn4WnUAIignaTvZP8TnETil
 /hjL7qHu42RhJOU95phu1aRVCUpEEB55wHIEBpJN/1/iFoLKjNp9CHvr9dPXSjALu0TI
 T9CYC8eZOaZClABztSFagreYghb/55o/yBu3ZBr75xkhzQh3DDsLwXWWtBiyzdJBd4Z4
 VS9A==
X-Gm-Message-State: APjAAAVxDrr0e0cas6wTfHHU/AnWB2LTcVVzUIgr3dx4tbRzA/r2kRuj
 6caIa/WaHzGassJwPuic7fU=
X-Google-Smtp-Source: APXvYqxsbFqWqDOMsMRaIbqujgVZy8Pquh8hunsrb0EyH/2JhfDdb3CIqqJA7RNEda9UlPQCe4BICg==
X-Received: by 2002:a62:4e0f:: with SMTP id c15mr4862092pfb.42.1568733347222; 
 Tue, 17 Sep 2019 08:15:47 -0700 (PDT)
Received: from [0.0.0.0] (li1140-19.members.linode.com. [45.79.41.19])
 by smtp.gmail.com with ESMTPSA id f22sm2585398pjp.5.2019.09.17.08.15.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 08:15:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] erofs-utils: resize image to the correct size
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
 bluce.liguifu@huawei.com, miaoxie@huawei.com, fangwei1@huawei.com
References: <20190917054913.24187-1-hsiangkao@aol.com>
 <20190917054913.24187-2-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <a52c0c63-5fb6-17b8-28f7-c5a0595016d1@gmail.com>
Date: Tue, 17 Sep 2019 23:15:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917054913.24187-2-hsiangkao@aol.com>
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



在 2019/9/17 13:49, Gao Xiang via Linux-erofs 写道:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> In the end, it's necessary to resize image to
> the proper size since buffers could be dropped.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
It looks good.
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Thanks,
