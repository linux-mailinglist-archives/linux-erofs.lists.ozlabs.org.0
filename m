Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 809858B065A
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 11:48:27 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=jLHOGsl1;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lxt7iJ35;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPZ1L6pH6z3cSL
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 19:48:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=themaw.net header.i=@themaw.net header.a=rsa-sha256 header.s=fm2 header.b=jLHOGsl1;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Lxt7iJ35;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=wfhigh1-smtp.messagingengine.com (client-ip=64.147.123.152; helo=wfhigh1-smtp.messagingengine.com; envelope-from=raven@themaw.net; receiver=lists.ozlabs.org)
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPZ185n05z3bWH
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 19:48:11 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 18EC918000FA;
	Wed, 24 Apr 2024 05:48:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 24 Apr 2024 05:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713952085;
	 x=1714038485; bh=q81krM1Vs9U606fIU6KUQTf+uKfBuwDQ5iIi2HAO4vA=; b=
	jLHOGsl1euXZ7eTXwTj6lerNWYdfqXp+tN4ypcJAG7g0UzZXTqHj8di+c4Wa9Dzn
	DBDcjunFPAFbAOorA8YDEH/OKLYo1xuFkPypEfZCS7r78VZd/xUHaWbzj6ZEvmiG
	w7pPaeyCRiR7HnaKQMgsF1FMVCeYNe8Lhrgeie3Pe5FTWmQNHbduG38f1JRM3dmg
	XJeYW5wHZCnVrmW4fdK4KVO8Grp7rV66AaT4G2Ka+v/ft2geaeZ78JQIL8kwEqNI
	fOCReesXDz7ZQvBpaKoUzQhWiXpInURtpwHFRkGEKRPlW4JbvxwxaCq5/qCmuTUz
	xD5oXFF7P5jJR/SHT4IDsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713952085; x=
	1714038485; bh=q81krM1Vs9U606fIU6KUQTf+uKfBuwDQ5iIi2HAO4vA=; b=L
	xt7iJ35J7EKX6uFXieAPLlgMDXUm2LGDVr7g1oZ0fWIUfrJ+dAH2gDGS+d3ffojp
	TfimAWuNF1i/A+XwstH9jUJKdQLH5H+fbPCcEdaQtuUwAeqQCox+11AFioI7HJQo
	Se+IlVSrGeMNmpuCEgcMzSKP+ssKqeEu6/SToeLsXsJ5lsEAdzoZZmH56Ssw6/rk
	4nXdSw3AbcZwDajWoakiybvSMMl5uiQQDey9G9VtPKUc+aUfjAgl9n+MpXI8PxKF
	0EAUn6dEpkdZ4prgCQr9yeu9H85KXzHnwquAvoCghmHJCXpsCEBun9v53ETBWl09
	24kuOjLnEjsCn1P9uy1nA==
X-ME-Sender: <xms:VNUoZoH_pLuBFJWUe1O9OcrY-zqXwR_ZTmC_t0T9W4Lp149f0CBDTQ>
    <xme:VNUoZhXMsNPlB4McHfmCScPNvZgeu3fNOr3T96OEMK6qre5PwWR54oZ7637zToOsH
    cvmaJWEdRS4>
X-ME-Received: <xmr:VNUoZiIbXkqXz4nruJy0W31tA57FmIeM5B-7OHTUHann471P_IQgdHHzLQgniYPQTXsZ73O3exvJrJUx424N1biuILGAZuNvfYm0CiUi2AEd4zWBgV7ewZBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eiudeiledvtdfgheeglefgfeetleejfffhgfdvheevtdeigefffeekjeffvdejieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:VNUoZqGFrfr5mIJtXt8JarVhuHQRdhrT5pG-FwDNOTu62IiAvI8w_g>
    <xmx:VdUoZuVPoKw8FqkApnb9Lypop9V30Bhxj3HUif0MJornQXGB0uLVoQ>
    <xmx:VdUoZtNeDEYrmvF-XLmG3a0ZaxI2ZLYk6Ch8eFnF5VUHuKbIxZND1w>
    <xmx:VdUoZl2Dl8d8T_cJgaNgA1nLKpJAnfbG-5EgnpBnjWjH1fNLnZWLKQ>
    <xmx:VdUoZriULVaZhNH18624NqGWdjNLSypidDP3vGWS1nRzVgUP0UCuWmm9>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 05:48:03 -0400 (EDT)
Message-ID: <e9c8a1be-b931-4528-a805-84a34aad5eae@themaw.net>
Date: Wed, 24 Apr 2024 17:47:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Trying to work with the tests
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20d564ff-bc61-42ef-ada2-2c2433f362fa@themaw.net>
 <e81eda7a-5bc8-49dd-ab68-029f7ecab0b5@linux.alibaba.com>
 <4ea8c79f-93c1-410c-9580-8f37e84f8548@themaw.net>
 <10812685-acd5-4c43-abfb-79cf82615396@linux.alibaba.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <10812685-acd5-4c43-abfb-79cf82615396@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 23/4/24 18:34, Gao Xiang wrote:
> Hi Ian,
>
> On 2024/4/22 21:10, Ian Kent wrote:
>> On 22/4/24 17:12, Gao Xiang wrote:
>>> Hi Ian,
>>>
>>> (+Cc Jingbo here).
>>>
>>> On 2024/4/22 16:31, Ian Kent wrote:
>>>> I'm new to the list so Hi to all,
>>>>
>>>>
>>>> I'm working with a heavily patched 5.14 kernel and I've gathered 
>>>> together patches to bring erofs
>>>>
>>>> up to 5.19 and I'm trying to run the erofs and fscache tests from a 
>>>> checkout of the 1.7.1 repo.
>>>>
>>>> (branch experimental-tests-fscache) and I have a couple of fails I 
>>>> can't quite work out so I'm
>>>>
>>>> hoping for a little halp.
>>>
>>> Thanks for your interest and provide the detailed infos.
>>>
>>> I guess a modified 5.14 kernel may be originated from RHEL 9?
>>
>> Yes, that's right.
>>
>> I am working on improving erofs support in RHEL which of course goes 
>> via CentOS Stream 9.
>
> BTW, could you submit the current patches to CentOS stream 9 mainline?
> so I could review as well.

CentOS Stream is meant to allow our development to be public so, yes, I 
would like to do that.


It will be interesting to see how it works, I'll have a look around the 
CentOS web site to see if I can work

out how it looks to external people.


Timing is good too as I'm about to construct a merge request and our 
process requires that to be against

the CentOS Stream repo.


That repository is located on GitLab ... so we'll need to work out how 
to go about that.


>
>>
>>
>>>
>>> I have a plan to backport the latest EROFS to CentOS stream 9, but
>>> currently I'm busy in internal stuffs, so it's still a bit delayed...
>>
>> Right, Eric mentioned you were keen to help out.
>>
>>
>> The full back port is a bit much to do in one step, I'd like to let 
>> it settle for a minor release before considering
>>
>> further back port effort. Of course any assistance is also welcome if 
>> and when you have time.
>
> Yeah, since you've already picked to Linux 5.19.  So I think I could
> also give a try if these commits are available on gitlab...
>
> I think I can help nail down the issue (fscache/005) too.

Right, there are only a couple of problems with the tests so I've 
decided to go ahead with the merge request and

work the test problems out those out as I go.


Ian

