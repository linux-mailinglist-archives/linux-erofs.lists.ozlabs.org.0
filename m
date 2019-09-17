Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 08565B5163
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Sep 2019 17:24:38 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Xn372JmszF3CS
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Sep 2019 01:24:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O6Kk1wHC"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46XmsG355PzF3yP
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Sep 2019 01:16:02 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id y22so2362693pfr.3
 for <linux-erofs@lists.ozlabs.org>; Tue, 17 Sep 2019 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding;
 bh=ZO7egx9iywiI6jCIQKdMC9fDGOjngOFgzrHf0Keg4XM=;
 b=O6Kk1wHCvqxsdu4Q4UFG25gLqEfWWbeQgdFXrPRi2GtxJ+KlHA+oEWBGPL/g93jKdF
 dYCyNG2dQX5HlqQg7mEZFtoOQ+0Ug9nBhlDpYsiJqo+dPh0yMrbsS0A2dmx7Aytp3zqL
 kjFg4PQG72aTAHkchFEUbwFJYUe+EDOoBOh3Mrbx8Y5L50XEqXO3US6ZVhINsnMgQFoc
 sWC6CClHyFIUnFHcybkmET7NAaTBe6o4ryfML3/AiToUZjbG3pIBBc9zDOcEEhTL7ShW
 PmAJ4p2/RD1F4Bf36VADXGIpNwU6PPqEkzIB4aUmskMwMucIiyA9FiT7BGnDn8cmY6s/
 S1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=ZO7egx9iywiI6jCIQKdMC9fDGOjngOFgzrHf0Keg4XM=;
 b=jCjiMmu1KfFzepMW+b6oLCr+pQRUY04AvQG7FH5sU3C4q7+MAVb9Y/aAGToYsdJYTW
 Wz4h5/x25QhG3BNS7ieJvXYxiIf11Fg8j0D2LxVCRpEPcz6laRab2pKrWuaHpFRu2NK4
 1Dt0af26JGmORSl0L7qcTLIvXRF36mKAeqNoQj+za00Cxgjrl4HABN5rmiCs0cyiR+3f
 Z98CV6q7LoZa4V9wQ+XtpvhpY7yTXMb+bymXSJAzo0xszEOf4sxTp74jW/hOegkYkc3x
 wgW4uX6XmkArEf2zNdPcD9g02JrYAG6gAIlpL5cAgYa6NpYBabMDyhu3lA5fm+CRFU5g
 qlEw==
X-Gm-Message-State: APjAAAUtBi6p7t67VOKuSKZZwxCrcMh4LZlCVpIBHh7KJV4MyaO24yRj
 etieOH+GRJBuqj98IT4n6kc=
X-Google-Smtp-Source: APXvYqyhgyE7zbfqt3N/3XieARhyN6WZ7UnQaAZ6/yrGBfgdU11Z9jc5h7HZM5d7H1RqFff7+c5iCw==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr3602934pgt.365.1568733359660; 
 Tue, 17 Sep 2019 08:15:59 -0700 (PDT)
Received: from [0.0.0.0] (li1140-19.members.linode.com. [45.79.41.19])
 by smtp.gmail.com with ESMTPSA id z4sm3690437pfn.45.2019.09.17.08.15.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 08:15:58 -0700 (PDT)
Subject: Re: [PATCH 3/3] erofs-utils: keep up with in-kernel ondisk format
 naming
To: Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
 bluce.liguifu@huawei.com, miaoxie@huawei.com, fangwei1@huawei.com
References: <20190917054913.24187-1-hsiangkao@aol.com>
 <20190917054913.24187-3-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <e802ed36-90ee-568f-6233-f9bdee6d2739@gmail.com>
Date: Tue, 17 Sep 2019 23:15:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917054913.24187-3-hsiangkao@aol.com>
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
> This patch adapts erofs-utils to the latest kernel ondisk definitions,
> especially the following kernel commits:
> 
> 4b66eb51d2c4 erofs: remove all the byte offset comments
> 60a49ba8fee1 erofs: on-disk format should have explicitly assigned numbers
> b6796abd3cc1 erofs: some macros are much more readable as a function
> ed34aa4a8a7d erofs: kill __packed for on-disk structures
> c39747f770be erofs: update erofs_inode_is_data_compressed helper
> 426a930891cf erofs: use feature_incompat rather than requirements
> 8a76568225de erofs: better naming for erofs inode related stuffs
> ea559e7b8451 erofs: update erofs_fs.h comments
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
It looks good.
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Thanks,
