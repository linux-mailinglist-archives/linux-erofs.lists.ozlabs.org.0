Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD23CCB0C
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Oct 2019 18:16:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46lsM736lzzDqMK
	for <lists+linux-erofs@lfdr.de>; Sun,  6 Oct 2019 03:16:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com;
 envelope-from=blucerlee@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hK0KM3fF"; 
 dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46lsLy2W2YzDqLd
 for <linux-erofs@lists.ozlabs.org>; Sun,  6 Oct 2019 03:16:39 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id y72so5732491pfb.12
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Oct 2019 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=uwTwBEBcU5tM/VEMwmOhoJbPM5kfxjcnln4KSWgv7iI=;
 b=hK0KM3fFPeB8homnbC0Mm+BpXXZcGxbxAp2pIUxD8YoFULxMim8lpCimobDuavaXfD
 HvWLS4TemzD0l0u/kN3/QzEte3auJlekP4ApOtIHYPCW2U4QEQPBIGCBkrOWxXT5zjiB
 WYYq/bAqPoWho5uHiN6biaVzcvFgn1lPXlJ/Ok7+DmnzyWDLvLs7MEkDItMYzqgXq/y9
 9u6i1JSMUgAqULy155TkMR6ZhC+hc2LGTQ5R7rGQWJ7qafifLW48/9uDUCZY7dPNx9u+
 XNgl5WdYdlAKOKqsfLDLqMSKLDFZ9MOu+FcwpHiBJPIMLE+I1B2naDbDmVxp9JlmBzOs
 Nxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=uwTwBEBcU5tM/VEMwmOhoJbPM5kfxjcnln4KSWgv7iI=;
 b=EpQKyq5mdOC+9tKGh1xoI3bQlmgMrMvVOG7Dyrr4lfAnLraYK5MW4ZY2sCWYIfGMCW
 znAaaF5ynAqnn0S3TbK8CqmyCyfXcdo0aoyLdIXoDVlDKu3+hSEKLoHmq1oUlGZ4JCel
 L1KTUxhwlXamO1gT8uwWmEgRNjfXfqjrVT4/xmS9ZePSyJ/1hHThNcVUwoKxxGq01sQ7
 rdKU3T6mUAXc9Pqw7uExlCJsCz+P78TWQe+OGONp4FggcBLos6TPNJ+CJVMK7UbWSiSI
 CiryVigYuYwPPp/M8P1ZrI/0ZD9YBGbceqcHC0kT/2J+avB4yTPS4jtyx01kTHJs2PbU
 mFTQ==
X-Gm-Message-State: APjAAAXaC8TuuBs5RmjZ4SULRvrVN5szDaKry6uc9Fk4ZGI7uCYb9Q7C
 3fze1f/Ox1RSJgOWMjpLYmo=
X-Google-Smtp-Source: APXvYqy+zIeZvEeV7z9/YevSPEuNDZSUXXoBkVQkmVLrnYvR5s4JSP/YGciCODezkxORchtNZXIHDA==
X-Received: by 2002:a17:90a:3ae7:: with SMTP id
 b94mr23648571pjc.63.1570292193824; 
 Sat, 05 Oct 2019 09:16:33 -0700 (PDT)
Received: from [0.0.0.0] (li2012-80.members.linode.com. [172.105.119.80])
 by smtp.gmail.com with ESMTPSA id q71sm9197093pjb.26.2019.10.05.09.16.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Oct 2019 09:16:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] erofs-utils: complete extended inode support
To: Gao Xiang <hsiangkao@aol.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191004204630.22696-1-hsiangkao@aol.com>
 <20191004204630.22696-2-hsiangkao@aol.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <a9543a49-52e4-9a79-a402-14794e1a17d5@gmail.com>
Date: Sun, 6 Oct 2019 00:15:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004204630.22696-2-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> There is no requirement to use extended inode (v2)
> for Android, but it's obviously useful for wider
> use cases.
> 
> extended inode was partially supported by obsoleted_mkfs,
> complete for new erofs-utils as well.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>
Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
