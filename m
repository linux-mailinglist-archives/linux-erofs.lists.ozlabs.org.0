Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD3D64DBEC
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 14:08:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXswc1FDhz3bf1
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Dec 2022 00:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aEAvO1gJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=tudor.ambarus@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aEAvO1gJ;
	dkim-atps=neutral
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXswV3nL7z3bVJ
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Dec 2022 00:07:52 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id vv4so52104759ejc.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QFzEy6ygu6+EnA8RiBrWi9hFfhLWiA1Ff3mZv4dGig=;
        b=aEAvO1gJxJkZFGke3o022BxYr48P8bsb33jOZ9q/EHRptP9G/BWMTC6SaEFz0v3HJp
         43y0z68NhPCxRuNlEBVI/OKLDsyQwz/2IGiqhMZom/uY50dOTq4smAr25REAREV55qSB
         HM4W+to/xAqtEv66jYA+bmKKrZIrDkDVM87afFcztCSm+EsTmTV3ZTJoViRft3Mj/grE
         mMAksBooIULXPlb6fTynbipJOFWpyeXDhKFaDRSZ1lXMh9e4tLy+OP6RuAcoV4mKI3Vl
         TcUY0yUL2Y8rsHgGq2AYMG3aTc4iVMVno9iZRfBNHrRXLPcgNXrJA6MGWvp13mCv4QhU
         iybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QFzEy6ygu6+EnA8RiBrWi9hFfhLWiA1Ff3mZv4dGig=;
        b=XtGbglYF5n4XOFthCP4oPekCPvdz24zjcNjfy90KWlPU3a2bwbQpkjsEj1xtWtspXq
         gvuX7Ye6lSveXeXev71nn+9HsodMYw9zFR+qcfwhMwOqLzExgivaymvnzgtj9aCAzWUp
         RkIYMiBY8yAtCjedVeia+0Des7zHJMQNX0N6Hz3fKEARbG10S9YFN4b1LGj7jdbbdRYE
         2AeT+QHStyAU5tR7TAU3CWT0boiQk2vdNw3hFVwkNhTzayPg53UmWBlD4PJJaokdktVv
         BfDE48CUyXBbbuMFuD6RihT788moUY334r3Z0hFp8xsWbBcNoyoZyTrRdjryPqtYvLpb
         chug==
X-Gm-Message-State: ANoB5pmUs9e00Dhf4x+9xqPuFoWmN0J05JJcZ3bJR9p9LjMnT8zijAPf
	MUuIUskhdeuJ6NFKKc83ljg9kRdxeKBWgAogfP4=
X-Google-Smtp-Source: AA0mqf7BqVPFeZfBhRmTFPRVxGKxu1eSmXVKjjsRo7rhRJn2pIg8XI6NMtsO6llc14PPgs/m0g+Wcw==
X-Received: by 2002:a17:906:8049:b0:7c1:6040:2318 with SMTP id x9-20020a170906804900b007c160402318mr9939275ejw.35.1671109667726;
        Thu, 15 Dec 2022 05:07:47 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.55])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0077a8fa8ba55sm7003673ejf.210.2022.12.15.05.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:07:47 -0800 (PST)
Message-ID: <68bae3be-9a98-83b1-a378-b7c7c12f74c7@linaro.org>
Date: Thu, 15 Dec 2022 15:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
In-Reply-To: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: joneslee@google.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 15.12.2022 14:58, Tudor Ambarus wrote:
> Hi, Gao, Chao, Yue, Jeffle, all,
> 
> Syzbot reported a bug at [1] that is reproducible in upstream kernel
> since
>    commit 47e4937a4a7c ("erofs: move erofs out of staging")
> 
> and up to (inclusively)
>    commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
> this round")
> 
> The first commit that makes this bug go away is:
>    commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters 
> (fully-referenced)")
> Although, this commit looks like new support and not like an explicit
> bug fix.
> 
> I'd like to fix the lts kernels. I'm happy to try any suggestions or do
> some tests. Please let me know if the bug rings a bell.
> 

There's something else that may help. I enabled CONFIG_EROFS_FS_DEBUG
while at
   commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
this round")
and I got the following: https://termbin.com/4bm8

Cheers,
ta

> [1] 
> https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a
