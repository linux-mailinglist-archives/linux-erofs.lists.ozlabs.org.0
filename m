Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 89242FB603
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 18:13:03 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Crlw5Lk0zDqsQ
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 04:13:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLehSEx9"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Crlq1LZ6zF6t9
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 04:12:52 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id p26so2073005pfq.8
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2019 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6AEQ9RrZR+9RH8N5IjdZj4Q6KvcxpZzmiej+sIUBQGA=;
 b=ZLehSEx91dUBfCLw9zyz3obqAuGQpIt2UBW2M2kC8ngtK6J/IGp5pv5Cr66cONW1hX
 qBrT+m9U8u89VHFcISKGBdMPPslJc/0LdVnAZ9XD4o3gki1HGPVnwDqinlbfsW1LeS8Q
 OX8w+Ka0u5jKS6wspPhF0RYvsPxw4ihfQqQo6CbWJFKxeQGQl+NRnk1GtnjKt2VycS9b
 mKqxl/CMQk+W7YmBG5zN87MdwDEC+C2PljU4jRAV11M5HIL1Dz5Ae6UjlLVdAaPzOmVl
 Q/paEBC6ihVz7kBJLhCP0pBQ5S8ggINprH+pJAyOHU4TkjklKJOopoAU5Ea5+YjViuCH
 BdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6AEQ9RrZR+9RH8N5IjdZj4Q6KvcxpZzmiej+sIUBQGA=;
 b=Bw08BK1wz4cLWymiDIH5ocmRVSUr94fTp1iuhUEs1C04KZE3Rp8bI0h10XZVcMMYg8
 Zqxo/kgoi4CA8M2/ugtCsZXX/dTKWBeqTSiwK0LAjOdePsPtoag92VegYIr/sVzSRnaN
 WY6ks+4uBxQuV0ry579snHyYmRMa3sVlUaSvYDhaFTBcvdoYGTglJXTNYnBg4akQuKmU
 FN3mMfaiyHMSysOdCFlS0sir/uVB5e1BhJgWISPOlpUD7atFwh89fnRCHD/6wos9cIZC
 M4oyO4GM3jIUhNFozBWv+dfmgsTqXf79hPdOoCcM/OjfA/YZO1/x+sh+kzvZKiRSicF2
 opzA==
X-Gm-Message-State: APjAAAWFk7bUwoXed5wRbi9rUhu0EtCouwcDGxHJ5oWZnMAzaJUSC7kg
 eE+U+CVtjc3cDFjCn7AVxBrDnKZM4bg=
X-Google-Smtp-Source: APXvYqxbP8m2ZzRK2ScYJliYtBGJ3xSDA5lnCfKmvO2eTH98l3LomGocyE8J4nIW/KE2nEEUf+5o5Q==
X-Received: by 2002:a17:90a:f491:: with SMTP id
 bx17mr6414086pjb.124.1573665167495; 
 Wed, 13 Nov 2019 09:12:47 -0800 (PST)
Received: from [0.0.0.0] ([167.172.195.219])
 by smtp.gmail.com with ESMTPSA id 13sm3207282pgu.53.2019.11.13.09.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 09:12:39 -0800 (PST)
Subject: Re: [PATCH 2/2] erofs-utils: set up all compiler/linker variables
 independently
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Chao Yu <yuchao0@huawei.com>
References: <20191112112650.143498-1-gaoxiang25@huawei.com>
 <20191112112650.143498-2-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <f38afa9b-7a81-d952-bc44-7c6c89aa477a@gmail.com>
Date: Thu, 14 Nov 2019 01:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191112112650.143498-2-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Gao Xiang
	Can you resend this patch ? It is conflict with uuid.
	uuid patch :
	https://lore.kernel.org/linux-erofs/d4d8127a-c452-f7d4-b3b1-50098cf07e12@gmail.com/T/#u

On 2019/11/12 19:26, Gao Xiang wrote:
> Otherwise, the following checking will be effected
> and it can cause unexpected behavior on configuring.
> 
> Founded by the upcoming XZ algorithm patches.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
