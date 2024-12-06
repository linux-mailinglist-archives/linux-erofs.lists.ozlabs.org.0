Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A339E9E6B42
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 11:03:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4RfZ22DPz30Yb
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 21:03:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733479413;
	cv=none; b=jgorVx9F/t0l9xgXgMIr/3hxYZAIRxFVq0dUCeOU9mMrWTQWMS6DdTkbZJg6yPqd6UNwnKp5DD2Yfaj1P8qRYG3QFnD2nB4Fjudhyvn3WfBzAnfAQ5XW5RoYGk4ysWYo5LpF1AoXfeJjfiysFsPgvARXMdDZGJKiweMBBP9dIIQ4398tIqCVyhQyb4OqHL96EQOoHILi0TyNRbUYULg1/h6pqwP3WT/P8g8Eoj9KpdTJ0Wsv5HzsQ+LqLPBIPRxzFvSqygNyt5TAb/sFSwidZT1w+qY4s2/xj9P8oBsKPsTgXlQU2n3EqYpKr5IUQFBfj3dOybqnQeHk43fLWpjynA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733479413; c=relaxed/relaxed;
	bh=HcQUliGx0CPnFNVSSB+Ho/Ucd+qkbG6AHImWNvzMxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYzdnGmFiMH8cL1wJspVVez1tyqYqh/sOp2sTd7BlKaOnJWQOejg6DjdD+RZTyRYIkNkPTFniNaj7KvLuWCX7XKHypy2BlxrZAY9NU3rTCiZfuZfqthwuaEcBWi4c5C0t1qhG1D3//oppd59ejpgbR6ZceKEwFA45AiPrN3c5hV56ODXKly5v7rlbTjV4kZIVoaxS6S0uqH4tmgk55vDhkHOJoq2kf7/wQsVB3+U7+XXN5ppm94Q2UIfFnpkKRnZRd1WEQ4ytozjKv0e+NuSdOTTBh3+Zsn+fF8x16rFbf6S3sMm2ABYz1q1Ixc+8/dfJdoq2egfj/+G/ZVVLkPrSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vt80R2Ns; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vt80R2Ns;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4RfX0jqMz2y6G
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 21:03:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9A65F5C73BE;
	Fri,  6 Dec 2024 10:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B396C4CEDD;
	Fri,  6 Dec 2024 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733479408;
	bh=Ap1bF6tpE1kN9IZDHlZczmoDx/8Wvs+W+qDpcfaij/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vt80R2NsReqpnWGcCPUkxZiG4jeEySfADYab8ML9nDpNx918R8/tw4ARXobFyLl3F
	 ymDdebMZB3id4cnWDULv6LRKAsddv7Akq5Bsutx30V1x+heflYNDQJzKteTME67opG
	 xpWdkJNOnfv2yWg4XKmNbiY0Y2h8u6Wh4NIFkZio=
Date: Fri, 6 Dec 2024 11:03:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
Message-ID: <2024120646-darkness-catalyze-a74a@gregkh>
References: <2024120228-mocker-refinance-e073@gregkh>
 <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
 <2024120622-prankster-lagged-01c8@gregkh>
 <a9d7b248-8c78-489e-99cb-f42d0c735d2d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d7b248-8c78-489e-99cb-f42d0c735d2d@linux.alibaba.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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

On Fri, Dec 06, 2024 at 05:41:11PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2024/12/6 17:33, Greg KH wrote:
> > On Fri, Dec 06, 2024 at 01:05:21PM +0800, Gao Xiang wrote:
> > > Hi XiangYu,
> > > 
> > > Just noticed that. Why it's needed for Linux 6.1 LTS?
> > > Just see my reply, I think 6.1 LTS is not impacted:
> > > https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/
> > > 
> > > Also, it seems some dependenies are missing, just
> > > backporting this commit will break EROFS.
> > > 
> > > Hi Greg,
> > > 
> > > Please help drop this patch from 6.1 queue before more
> > > explanations, thanks!
> > 
> > Now dropped, sorry about that.
> 
> No need sorry :-) just wonder the cases why we backport
> this commit.

It was done so explicitly here:
	https://lore.kernel.org/r/20241129074059.925789-1-xiangyu.chen@eng.windriver.com

The submitter should have cc:ed the developers involved, I'll try to
poke them to do that in the future.

thanks,

greg k-h
