Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F29E7DAD
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 02:15:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4qtM2rtyz30fg
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Dec 2024 12:15:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=121.200.0.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733534105;
	cv=none; b=jQMkkGgFQccPE58uiZ3gJD4rsnkIcOR0Kov35mxUsA3aqz51hMnNTZX/NIFP7ihXR3u1Wzo27Fs+OSad+hniMj/wib1Tvrzl4RpUHhE2OmQmtXXqSV93YOBTesT/L68sYvCxMuRK7oLhPxXDhvUZiBl1Ch532pO+veqX6MmDpI/erP15beDCBp5Sk+OOJy73Z9cxlhYM50gBcmERrAgjFnZ0qxz8HhldxDiuLko5XA2AdnTB0XuglcjxUqFDiZmloSSZ2jdwbjbb01Bzk7QrxZJ2dC/ziVa7ZamjrP3ZbYxAc7slNIlYl7bM0ZfKSooCuTmMZZGcnXcbYOOpkKF9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733534105; c=relaxed/relaxed;
	bh=GRaL2hK8NuZlae8PyxIIhe3sHr0DVaE2w+vRrG38gsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lrOfI84ak/9tkF1zNUDoayF+eGGVt1IBhj1Ibe6cfpVhamWUkKkG+BJ4OR8sJyla3DMf28KFR5hoPze5Q01IccdAsExOm2W0GaBdj/Tedaf3QYRQOd3NHqtkAKvO2+uwJpS/0faFp3MBm+Rr9qWjhclN3ouQqVXuKBtxszrVaFkN3U0CAYzAsT/w90TDcT2EJaqn5pw66/tYizFaPSIQRJpAkhZjo4i1DExvhZxSxGkGoNWcUC7gI1dWg4ndGJsFsm1imTJp+amEijNl0B37EmtXxLVCqtSUenmpIPhtLekvjqXsJK7M/6OPZ8yH249arCXyuCM3QLLGIg9q2KWcCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=neutral (client-ip=121.200.0.92; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org) smtp.mailfrom=themaw.net
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: lists.ozlabs.org; spf=neutral (access neither permitted nor denied) smtp.mailfrom=themaw.net (client-ip=121.200.0.92; helo=smtp01.aussiebb.com.au; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 332 seconds by postgrey-1.37 at boromir; Sat, 07 Dec 2024 12:15:03 AEDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4qtH6Y2Qz2xs8
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 12:15:03 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 567E910041B
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 12:09:28 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqfQpFjBfcda for <linux-erofs@lists.ozlabs.org>;
	Sat,  7 Dec 2024 12:09:28 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 46D31100462; Sat,  7 Dec 2024 12:09:28 +1100 (AEDT)
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=5.0 tests=SPF_HELO_NONE,SPF_NEUTRAL
	autolearn=disabled version=4.0.0
Received: from [192.168.1.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 30EC710041B
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Dec 2024 12:09:26 +1100 (AEDT)
Message-ID: <92d6b2fb-f06e-49ac-afe5-cccce5d75a92@themaw.net>
Date: Sat, 7 Dec 2024 09:09:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mounting 4k blocksize on e.g. 64k hosts
To: linux-erofs@lists.ozlabs.org
References: <406ae215-0f60-4f19-9be9-122739682056@app.fastmail.com>
 <17b4f35e-a365-4460-b2a4-9da660ae3e95@linux.alibaba.com>
 <55ea18fb-7309-4328-a2f9-bebb5db61e87@app.fastmail.com>
 <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 cmF2ZW5AdGhlbWF3Lm5ldD7CwXsEEwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 BQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPiLJ0EE9eJkyV1rqtzct5Ah9pu6
 LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UVCxERgQBOJcPrbgaeYZua
 E4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjClW3ifdD75gHlrU0V
 ZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4W0VgpWczmA
 tHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+YK/0L
 Q2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPw
 DSMZ2NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVn
 cOqyghSE69H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8
 J/tYvFMpag3nTeC3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0zsFN
 BE6c/ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC
 4H5JF7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c
 8qcDWUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5X
 X3qwmCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+v
 QDxgYtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5me
 CYFzgIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJ
 KvqAuiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioy
 z06XNhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0Q
 BC9u1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+
 XZOK7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8n
 AhsMAAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQd
 LaH6zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxh
 imBSqa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rK
 XDvL/NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mr
 L02W+gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtE
 FXmrhiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGha
 nVvqlYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ
 +coCSBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U
 8k5V5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWg
 Dx24eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <99520f27-6080-43ae-9c60-cc30d3a8ff5f@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 7/12/24 04:21, Gao Xiang wrote:
>
>
> On 2024/12/7 04:10, Colin Walters wrote:
>> On Fri, Dec 6, 2024, at 2:46 PM, Gao Xiang wrote:
>>
>>> Did you try upstream kernels? It's already supported upstream
>>> since Linux 6.4.
>>
>> Sorry, my bad. (It should have occurred to me to check, but this one 
>> popped back up on my radar when I'm trying to do several other things 
>> at the same time).
>>
>> Anyways looks like the fix specifically was 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 
>> ?
>
> Yes, although it has been supported for nearly two
> years, but there are still many dependencies
> against RHEL 9 kernel (5.14) codebase.
>
>>
>>> I think RHEL 9 is lacking of many features.
>>
>> Yes, but I'll try to argue for refresh for 9.6. Thanks!
>> (Just tried to cherry pick that one myself, some conflicts but looks 
>> tractable)
>
> Actually, the PR below has been delayed for
> months:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/4123 
>

Indeed, yes.


I deferred it because I thought back porting the idmap type changes that 
came after

5.14 was more important and the above MR was conflicting with them.

That was a large change and was difficult to get merged but it's done now.


>
> I think it's not quite easy to just cherry-pick
> random commits due to twisted codebase cleanups,
> rolling the codebase to upstream v6.4 is a good
> choise for RHEL 9 long term maintainence.

Yes, cherry-picking commits is often hard to do and error prone.


I can't remember now how far I went with the above MR but I'll review

that when I look at getting this into RHEL for Colin.

If I need help I'll certainly reach out here, thanks very much offering 
to help.


Ian

