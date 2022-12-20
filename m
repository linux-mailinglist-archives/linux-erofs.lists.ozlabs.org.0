Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC46523D7
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Dec 2022 16:42:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nc16l64rkz3bgK
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 02:42:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g+CrOS8T;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=tudor.ambarus@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g+CrOS8T;
	dkim-atps=neutral
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nc16d27WSz3bNx
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 02:42:30 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so30115202ejc.9
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Dec 2022 07:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/ge45M+uLmbjheub/WT6HdLM4XPrSEquSgTSYE+1+s=;
        b=g+CrOS8T/Z1uS8VZcpmQln5szwk22w2uuuSXfVzD1rGmZFrYXZjBz98w9dSw4HbwVn
         T27TcRabPTfkSzGB+1yrXoZ4vm7S2vJl6NUffdrX8iXoANBQdeN0peVeun71lqvO5iyw
         86RnFQs277o3fXX4sWWMtKwngKuTOds6nkgtbJ5WAq1tWdU7BtHbNCJpnZwzlYJM96MI
         OZWj93EhiSWq+JxUCpVsFp9d7hF2uifb5FyidjSe3TkN1Nlxu/yzRLCBlJTSG1a5T38r
         ul7w646UGnNB51wnyv7YYYqBdbYTYTO4oww0SxhPQyd78tmXuL5TisbW4i3Dg90cbCSB
         dqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/ge45M+uLmbjheub/WT6HdLM4XPrSEquSgTSYE+1+s=;
        b=1FOgDY/lnlaIylj98lJ2SLU5wwvo4WsWbVTMBeKazXcd5ssPN+qxVoKZZcSzaT95jX
         p//QChYB5W+HIijRlvY7A5Xr5Y3SZdVS+94G2Re0Eo9zB931jtAcf1K0OkiaeIxC21cp
         sxzBVsg4x6wUBqfjWoCFsSOitvZEkin8K9TbtTvUVmxxDOfTxR696uBWjJ8L4b481i7f
         UTKmO4JAizDXTB7zaww2MDetOuMq9ftDt9cv4Kd7JYmhv3aBtcpdqVKGhIAj7pNmavWL
         kH99Epi7BOkI6z1Pum3UWBitSwVS2o1Qs8ANfhjtiyJ54LEB4FGRUm+8y8SHg89tv/3P
         +R8Q==
X-Gm-Message-State: AFqh2kpOgTH4PRU4cCtZqgjdY5Okj9zwDI2ha4LryUq5THt2Jx95/cJM
	/IsirQPxWYVX/sj3wc24dodgmg==
X-Google-Smtp-Source: AMrXdXs7Md1pBd8/t2/TfHBR9r7u2xCDkfkmIpR6Y2C7FNaB7lyB34N5hlx5URjr382clso66ViGhw==
X-Received: by 2002:a17:907:8b92:b0:7e8:cf25:4b9c with SMTP id tb18-20020a1709078b9200b007e8cf254b9cmr14902492ejc.59.1671550943513;
        Tue, 20 Dec 2022 07:42:23 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id bq15-20020a170906d0cf00b007933047f923sm5723277ejb.118.2022.12.20.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:42:23 -0800 (PST)
Message-ID: <947527a5-f345-b7c8-6938-9a8d2863fbac@linaro.org>
Date: Tue, 20 Dec 2022 17:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
 <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-kernel@vger.kernel.org, joneslee@google.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi, Gao,

On 15.12.2022 16:24, Gao Xiang wrote:
> Hi Tudor,
> 
> On Thu, Dec 15, 2022 at 02:58:10PM +0200, Tudor Ambarus wrote:
>> Hi, Gao, Chao, Yue, Jeffle, all,
>>
>> Syzbot reported a bug at [1] that is reproducible in upstream kernel
>> since
>>    commit 47e4937a4a7c ("erofs: move erofs out of staging")
>>
>> and up to (inclusively)
>>    commit 2bfab9c0edac ("erofs: record the longest decompressed size in this
>> round")
>>
>> The first commit that makes this bug go away is:
>>    commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters
>> (fully-referenced)")
>> Although, this commit looks like new support and not like an explicit
>> bug fix.
>>
>> I'd like to fix the lts kernels. I'm happy to try any suggestions or do
>> some tests. Please let me know if the bug rings a bell.
> 
> Thanks for your report.  I will try to seek time to look at this this
> weekend.  But just from your description, I guess that there could be
> something wrong on several compressed extents pointing to the same
> blocks (i.e. the same pcluster).  But prior to commit 267f2492c8f7, such
> image is always considered as corrupted images.
> 
> Anyway, I will look into that and see if there could be alternative ways
> to fix this rather than backport the whole multi-reference pcluster
> feature.  Yet I think no need to worry since such image is pretty
> crafted and should be used as normal images.

I guess to backport the multi-reference pcluster feature is not an
option for stable - just fixes are accepted. If you think it is worth
fixing the problem without adding new support, I can dive into it.
Let me know what you think.

Thanks,
ta

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> ta
>>
>> [1]
>> https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a
