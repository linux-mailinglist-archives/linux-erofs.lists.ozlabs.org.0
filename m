Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E9E07E9
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 17:52:26 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yJ135hR8zDqDy
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 02:52:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d99/PvBg"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yJ096jQxzDqLr
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 02:51:37 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id d22so8545038pll.7
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7sgS4DBcCSZDH6k38fndK4SquIzeQnBi/vP/up0zF9w=;
 b=d99/PvBgLw1UOzHpCVs7HCxFc2mIpSL5TXLy7+CyucodTtSNKFhzlYE4ZgEol1Mt/Z
 sAJKhDE3ORgZKcrhApSdQM+KPzWmGppbyBpwSe4JopNfmvJAOK4dEfY8Zx+ENbT+42nP
 4XcNfsmcHBtXxPQAlhtKaNKwdNuqkY8FPMSneem3wOS/XOnim6UCQ8qpAO/10QzoZkJc
 8C12ULOP2Kxj8EhB/yU66kvpFJrxjlO5+AjoASfGoZ1rUlFtK6HSbErlmHATsgnkEIKi
 Vs1TKjUIU8lZA4EJfaBUT4B+e9b9Tikj0UHp2JN92RB/f23lWSlys7OAMfNtu2mKiiw1
 vJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7sgS4DBcCSZDH6k38fndK4SquIzeQnBi/vP/up0zF9w=;
 b=H3zudbIDCoVFOFIVNUT/Q5FEK5T4E25gpkv0jM5JKmSrR9yT5zlWvgpG2oZCJ8CwOy
 /0W7lcA4Z7MlrDlPkkL+lL3Gnjjxt/GjEHfmHR8Sl3KKekGh9kT045iXFE9U7B8hrfyq
 Mn7YJpcVc+FFMUNV7GFHChQ5POztV/pkhyCqyrxrVsWXlrGJ3VAvfMLMolfudPryOmmW
 szFa3Gjj6T4arxlWIMDpuD4tEYMp1mPH46M3M27uX2wCg0wapsKxGPTkHoclt+RtNeH/
 aSMuYyWGQICYTsByPvT/xZFqrY77gnALTFZ6csOwyjGHEBGx5tBqDXjtsN4jsfOw/v9o
 M95Q==
X-Gm-Message-State: APjAAAXe0EOE58Lfnx29241sPB/N6ExnUc4JeKnLnvzaDpVTweO1t+En
 mdOQNqkEfiVrfj362ej4OPs=
X-Google-Smtp-Source: APXvYqzqQhLFO6lls6gE9g2NgXJ/5JB7+c+EiQ3ZL/8JBHafo1vZbEUMg2wUWStU0dbci13wCC82qA==
X-Received: by 2002:a17:902:6b07:: with SMTP id
 o7mr430699plk.215.1571759493887; 
 Tue, 22 Oct 2019 08:51:33 -0700 (PDT)
Received: from [0.0.0.0] (li1104-154.members.linode.com. [45.79.5.154])
 by smtp.gmail.com with ESMTPSA id g12sm20009267pfb.97.2019.10.22.08.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 08:51:33 -0700 (PDT)
Subject: Re: [PATCH v2] erofs-utils: introduce long parameter option
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>
References: <20191022025053.GA180717@architecture4>
 <20191022041009.55166-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <e920ef02-6ec8-cce3-504d-2405b2178f08@gmail.com>
Date: Tue, 22 Oct 2019 23:51:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022041009.55166-1-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/10/22 12:10, Gao Xiang wrote:
> From: Li Guifu <blucerlee@gmail.com>
> 
> Only long option "--help" is valid now.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---

It looks good

Tested-by: Li Guifu <blucerlee@gmail.com>

Thanks,
