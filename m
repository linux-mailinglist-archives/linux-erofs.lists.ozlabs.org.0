Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B485E1F6B
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 17:36:59 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yvcm1tZlzDqQS
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2019 02:36:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ak32Neou"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yvcf2vNDzDqLf
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2019 02:36:48 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id a2so13163700pfo.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QLbbYV4jKkaJ1xGz4g7PsHjRm1JRjnHVmb4EikAD+Nc=;
 b=ak32Neoup11egptq6mgMuHnj9/yu6hhv+YinxbjC78RvO2ooRdZo7fgdSZqq8u85CV
 2TQ6qnWKqC7eNYParCE4pBTcfuzL+sg9sGS1zbwWUiimg/SKw6C1nRG5h1yKYyPRie8j
 glpdxlkKRN7IliwBhGP7OU6DrtsykBgHP9sPy8PfyKmJZQiERL8nO5SksnsSPTsAYJI0
 cfw6f3lH+EUgyprjM5pf9ZNzsiMSeJTTXtx1f2zYzYncXnuFQvejrj7t93pGD4V7MGm+
 +7Ya+5QUmnKnjM4ZvS/bHfIQPIpYumxD+8gCGsTHdHuuUjpgSj2CMYYR0B1NVTb0tHJH
 WTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QLbbYV4jKkaJ1xGz4g7PsHjRm1JRjnHVmb4EikAD+Nc=;
 b=B2vsTxlHL4Qi46HtXJ/q2kwLXqADIAKCEsb3VCSdHA5kcpzi1+9ax/BoHFYap0JXWt
 wYZX22DEE4195rvE7J8udg4qCbKlTJPyXT6eCz9srLeHGX0ESP8Y+8Raow5GPd22fobk
 N3k29ILZo1sCerRrq3xWzGl9Bvq14QJccSOggqF5FC2WchLiQChfOJFbSTBbr/JLT2AZ
 Dl3UYeffrSCGxGdHgUSzN7fVjHWvxdAW9NCD1FU01dLlsRy9gWCNeN/zU4fq9ZXBwoe+
 N0nS82LAh32qiqNKhMgUm1h/LfULf4nZOjTz1HfJWI7glVyhnYAU5Zirr7VZ5llP2pw1
 jAbg==
X-Gm-Message-State: APjAAAVXRM3TLw+8q/yNmJ0a3UoRhnnaOi612qeZVsCw+yHZ6rbHzO9P
 DWBFvmUnM2I9/GWWFfN3FpQ=
X-Google-Smtp-Source: APXvYqxFIsH6i3FEWETwCfmMutPotZ44OjERA5b6Si8GIn+Ix9fEBS3MOhIj8VA9ntrNqRUQy39Tww==
X-Received: by 2002:a62:1bd3:: with SMTP id b202mr11482400pfb.50.1571845004076; 
 Wed, 23 Oct 2019 08:36:44 -0700 (PDT)
Received: from [0.0.0.0] (li1104-154.members.linode.com. [45.79.5.154])
 by smtp.gmail.com with ESMTPSA id j10sm23177521pfn.128.2019.10.23.08.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 08:36:43 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: simplify prints in usage()
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191023063718.152278-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <ce86d14e-8fda-e75b-7b24-8e047688909f@gmail.com>
Date: Wed, 23 Oct 2019 23:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023063718.152278-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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



On 2019/10/23 14:37, Gao Xiang wrote:
> Use a single puts instead, trivial update.
> 
> Suggested-by: Li Guifu <bluce.liguifu@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---

It looks good
Reviewed-by: Li Guifu <blucerlee@gmail.com>

Thanks,
