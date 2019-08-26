Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D19D237
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 17:01:30 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HFZb5bFPzDqcx
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 01:01:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="K1fPfeIC"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HFYp3YrMzDqc8
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 01:00:45 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id f19so10163894plr.3
 for <linux-erofs@lists.ozlabs.org>; Mon, 26 Aug 2019 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=y05JoCwyZAklLkZKj7ea6f08y1IpJyCq24ihfEcW9gA=;
 b=K1fPfeICWEkstVWrq2KFYDzGYV7q6Y/rCCLsqpYweNBtUvb9IORvmbSCstETJ2Ooi7
 t7cV1kGRkcYe8/iNUbwaZv5a9Su0rdVYO9zRpYnaqF+EJsNqNuMfMw4WLSdL87ydOJND
 IEOnYKwUbfc1cSONWJd1dHCpB/TlrbtERwjyB5ObGprH9UnBDa+qtNnV29ZYwzILmBs3
 gcjNNkYHi414bAYUy/Yz1Tib7JKUEWZVxeJi5jeufIv1rWBnV9sKO9YkF/YJHyg2aLg7
 Ao8QYoxjQYborICco/04sc6p8YCx80S9VEp9r+UJZ/4krf1nbNTCuMSiCicrysCROqJ5
 q18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=y05JoCwyZAklLkZKj7ea6f08y1IpJyCq24ihfEcW9gA=;
 b=nbUL3R7PR/wBGafa897hCIX8pkpxpUZf6a2/+N7XoydrvJlRvf7ZX5DygEVc88/A/Z
 QT3OZw6zxqziDLA2gl9UwGPkriIz608YQ01qjU1C4oLLnf0oRU9/LHRAB0e4W3nuKgg0
 CflVFnz9YMH2/4F3nnz8o7UlaFyWXHTdO+EIJi0OPuGHJ6BGzMqIhBlU3ef2b7ytNnKh
 KVAi4Z1trnxSUBOjAJX01XoqAzIyaZ1I6DPVnZocBl41+3ybDp5nsneLOY+soV47RqBw
 Egxx2D90I4e6IxIKNWY/sKTUGW2G4zWlJ1GxdGmhm1xU/FMzbuet3xg4Gj37M4OmHpBX
 7HXg==
X-Gm-Message-State: APjAAAVeV0TcQDSf0+PxQoqWhFFNnXR+vB6DMxaqI8enOYtol9brOxtv
 qlzRskam6mln3OZGbv+Ji8stJGWj1Qa2zI2G
X-Google-Smtp-Source: APXvYqw/bHpQzp0ByorxE/L5ZnAqTti7PUFOY6Pa0z73UvJhDpotGuptuXiI2NFEUTY3f9F7swKa7A==
X-Received: by 2002:a17:902:9889:: with SMTP id
 s9mr19774504plp.100.1566831641122; 
 Mon, 26 Aug 2019 08:00:41 -0700 (PDT)
Received: from [0.0.0.0] (220-136-220-14.dynamic-ip.hinet.net.
 [220.136.220.14])
 by smtp.gmail.com with ESMTPSA id p10sm11431845pjr.14.2019.08.26.08.00.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 08:00:40 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: fix a memory leak of compressmeta
To: Gao Xiang <hsiangkao@aol.com>, bluce.liguifu@huawei.com,
 linux-erofs@lists.ozlabs.org
References: <20190825033638.30216-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <57313d60-291a-60b7-6eaa-940a2baf1de3@gmail.com>
Date: Mon, 26 Aug 2019 23:00:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190825033638.30216-1-hsiangkao@aol.com>
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



在 2019/8/25 11:36, Gao Xiang via Linux-erofs 写道:
> compressmeta should be freed after successfully written.
> 
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>   lib/inode.c | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
