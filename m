Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6C99E6C64
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 11:38:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4SQY1Bfmz30Yb
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 21:38:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733481492;
	cv=none; b=Yq8gG4eBpDRyW8C4rALNDCJzykxibRNdImwbkQv1ky63y8RGilFm15MiBBUaEG2ii/Ticn3KHINM1hoOlrH5w1XKpdqi9pDLz5DSLznQAhL7hkSY4UhsI8YdNkdIYN/t6XBlH3OUjGl7CRi+ztT/oqvDjJLrqdO5rIgO9lhxpHjGugbe3ZOD6w0oftM4Hass0Y+AhyUUTPdqFVyWh6rm0elE3n2ZZIRjO0Xo2YO2JbnX90tBSTBF7GfmIv3RXEY7i7YKQyQNr0q5cJZpTXpdKaWzycZrC2JDUDWRs2nApk4DGtuhH9ArVV7UcGHO+ZvXkqIyIEGEqJ4RPoX0bUe96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733481492; c=relaxed/relaxed;
	bh=KyoD3R4r8x8kaH8Xlskzh3egnV+xkYhWE0Ry0IGSXOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU5u74MBDzunrontibcCOcjXHszigQJq2MtUXDFUtdowf0lxpZUg/4p+11nJw3uM1CtXCCjZTNqaOZKlPJWhknEeFNJYd/S7tRSxXVZKZuXPLjC15AASRGtbXoOhC43vijSuASeYlJi7CPtSqCA3/4c/XC6YvqYZVI2G/+6Hvryg2bOklS1YAtEF3PencUhRTiiypEE5lTaEHOoPCEEiPdpt3CnOp/yWPtAhhqu9/cR07s6DOElnfRtLrFDyruBwKoVt3z0txzK0biWaFuhSitlBo3xyEtfGhIarHL2Wn0ZM3OFBmC/FDWNJfbQffF++PXHnt+JIBYYjTw8PLMSG1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V7dHrmSn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V7dHrmSn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4SQQ3h8pz2y8V
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 21:38:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733481476; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KyoD3R4r8x8kaH8Xlskzh3egnV+xkYhWE0Ry0IGSXOw=;
	b=V7dHrmSnZybeXepYSfmiompU/v7aPrO17VnuBmk8CLybYXF0Bf0lBCiQIt+Te+BhyECyEYB8hAfJYZqMMESdeLBGIrRd7zk6c6nbXVANdEuG/ONjmzZoAxWAT+xBjDV+G4HjdSretRAfGAb/+zV+FltSYgkiTuLX3ujd3qU2zh0=
Received: from 30.170.86.122(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKwNGn4_1733481474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 18:37:55 +0800
Message-ID: <bdb479e2-baea-4824-89cd-4449c044e441@linux.alibaba.com>
Date: Fri, 6 Dec 2024 18:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
References: <2024120228-mocker-refinance-e073@gregkh>
 <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
 <2024120622-prankster-lagged-01c8@gregkh>
 <a9d7b248-8c78-489e-99cb-f42d0c735d2d@linux.alibaba.com>
 <2024120646-darkness-catalyze-a74a@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024120646-darkness-catalyze-a74a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Christian Brauner <brauner@kernel.org>, xiangyu.chen@windriver.com, stable-commits@vger.kernel.org, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/6 18:03, Greg KH wrote:
> On Fri, Dec 06, 2024 at 05:41:11PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2024/12/6 17:33, Greg KH wrote:
>>> On Fri, Dec 06, 2024 at 01:05:21PM +0800, Gao Xiang wrote:
>>>> Hi XiangYu,
>>>>
>>>> Just noticed that. Why it's needed for Linux 6.1 LTS?
>>>> Just see my reply, I think 6.1 LTS is not impacted:
>>>> https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/
>>>>
>>>> Also, it seems some dependenies are missing, just
>>>> backporting this commit will break EROFS.
>>>>
>>>> Hi Greg,
>>>>
>>>> Please help drop this patch from 6.1 queue before more
>>>> explanations, thanks!
>>>
>>> Now dropped, sorry about that.
>>
>> No need sorry :-) just wonder the cases why we backport
>> this commit.
> 
> It was done so explicitly here:
> 	https://lore.kernel.org/r/20241129074059.925789-1-xiangyu.chen@eng.windriver.com
> 
> The submitter should have cc:ed the developers involved, I'll try to
> poke them to do that in the future.

I received that email but ignored it accidently‌, I meant
I just wonder the original reason on the Xiangyu's side.
Is there something wrong in the production?

Sorry for the confusion.

Thsnks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

