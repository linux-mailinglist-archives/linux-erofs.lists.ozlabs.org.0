Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 79884FB53E
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Nov 2019 17:37:06 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CqyS0PhvzF6bv
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 03:37:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="U08GruVf"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CqyK6wRczF4J4
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 03:36:57 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 29so1700997pgm.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Nov 2019 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0lKv8fKJfQLpbcFy/lDHuzpnfn7PGaoHVSsIr+uju4w=;
 b=U08GruVfMyAbc12LXymomzj+BCRA4/SKCRfJST6sfd0Gy6BliuWdPb+U5dAFSFsDi4
 KHysR6/LpGTCNb5pwYxIui7r0vkOahjzGIb2CPjfK/Bj5o1FadTQYSTyuxk3N4G1NNh2
 VeyjGPSJ6K4fWramxNrIQpesWF1KfhUDkyjEAcowP+kJK9YSH8IOm5LWfwpDEp9TH+Yj
 ORfbn0w4yvSazqV0wReByteyum3WGAw911QLnX2ZofsdsxVsFS8CIsnUSfJxYUZKKWTG
 kMob66je9mwahGekD4ZJsKa0c7NAaIz2w4QW+CloIUHNCWxDxxW3ynkAZPZFDlARyKMA
 B2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0lKv8fKJfQLpbcFy/lDHuzpnfn7PGaoHVSsIr+uju4w=;
 b=pwl1V0oxi8D/1DaFMoXhzyRmE0yvcTB23kz2PjK9FTbjVftLhnWVzv5r8xn2mGVmk/
 L9ae1cPCxB/ig+RwCITRk7jaaGPyGwurUVYrANxH248hyChCELM9vKVgulbf76Gj9oIl
 LGzxqf8A3jHDFgUqnDM/8WQm0tWnrSVnpGN6Ssee2oteAUBMvHQbNeScTYpW4quFPBxQ
 Bp8pcS1ttBY5hXJbW4zGJ/AechMdzGFFwqhFp8/KFt2CNSHYkhucpj1TEP0OL1/SHica
 hMDFLiyrlgucxrGQ490BYZPLSRKBiCTZpM201AEOPnYIHzbq5JqyZjsASvjmRlM4VTST
 g/hA==
X-Gm-Message-State: APjAAAVdV9ClZU1dBD9sKA3uH7K8zaXpjwu9xzhVkB8xgQPPjPXxg6o8
 YbLfPpNGy5F7cewMukz9s9o=
X-Google-Smtp-Source: APXvYqyQ2Qrl4ibBtllzygyiFmLwm/vnES7Cwh5OyVZ7YNCS0oiWepiTM667nYSnhZq/jQVYNJj86Q==
X-Received: by 2002:a65:48c7:: with SMTP id o7mr4737465pgs.276.1573663013664; 
 Wed, 13 Nov 2019 08:36:53 -0800 (PST)
Received: from [0.0.0.0] ([167.172.195.219])
 by smtp.gmail.com with ESMTPSA id i5sm3054965pfo.52.2019.11.13.08.36.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:36:52 -0800 (PST)
Subject: Re: [PATCH v4] erofs-utils: support 128-bit filesystem UUID
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20191113035221.30265-1-hsiangkao@aol.com>
 <20191113060141.9502-1-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <d4d8127a-c452-f7d4-b3b1-50098cf07e12@gmail.com>
Date: Thu, 14 Nov 2019 00:36:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191113060141.9502-1-hsiangkao@aol.com>
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



On 2019/11/13 14:01, Gao Xiang wrote:
> Complete filesystem UUID feature on userspace side.
> 
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Li Guifu <bluce.liguifu@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---

It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
