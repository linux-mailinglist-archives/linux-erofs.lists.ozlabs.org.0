Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D82619E6D51
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 12:25:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4TSh525Pz30Yb
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 22:25:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733484306;
	cv=none; b=LBLFesVd/4XZSfqKScJUoUx/3csGSoJSC8sRse+cHZ+SZxYLN+Y73clhep6L4YUafoS5YhqbXFlhzSlVssPa1Sw/lRPb524RtVfUq9m4uTG1fMwq5ThJfnkGHJo+zA3ZJUJ81Pq0O5l+GBi2FRz60VPkemZZNPx6E2ksaAoiqRuwVb1JAoE7/SBDfA0AZsq8Or32xO0mNopgNGsW4n+6+rqQ0JDr5/F5x6DxV5r8jvRsymeDoGIwKNbKw8rpI1kjQx+pbL4Ub1KOsksNl8hY/5HDvwqQh2mpXsd8VB1aS0NZi6xdyVXhZ/WgARb/MclhS0+dBcHwXRGBqqT3LNRguA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733484306; c=relaxed/relaxed;
	bh=9j3f4BZ13CSzYDjCPlXC33NhPaJ4SwYwl1rIFRGI2yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV7kwDhB3ILRp21wrDl209k38+D48HQwc2AxXn8b8Ym03aL2X6qLaufC5eNXXe1wQaw54wZrPkRiHULZKDLVWEfLxGGrd++NwkFzNogTAmJehN+aaIf6P3Kr3euF9CKSBNIqAYvmIc9YvMRC7V98v+c0JJ9ArHnorV+fZgrQiuMINoN//3VWyIXq6LL7h90RT5j7yFrPW1NeKlSZgFDaD5GtKkDmEDwE62LZRarf+JTf5GPnFx+Pp7wjdh5ihrQYtMbMv1yT5P7xSDF6dalEjqC00deFQaP/09Tf9jjOEwvv5eumZ4DX2IoJUwE0slnw6f504u2UnRlOzALtVsHe1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HPxAZ5ft; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HPxAZ5ft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4TSZ6Qcdz2y8d
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 22:25:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1B8FE5C5A29;
	Fri,  6 Dec 2024 11:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6143C4CEDF;
	Fri,  6 Dec 2024 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733484299;
	bh=QDgAETvaxdR/DPX8TFtgz4aHrld7jWFEuX/8HIFcMEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPxAZ5ftFtn/IbCjr4LYviE7hCS58RLtmveFOk5MGERy6vz4gHBi2bQ/0eO7SIYcu
	 znc+ItSwDz5lZAZIgdCfTzBaD5XDqlP+8daWztKQb860bwSCLk7wNcnxLe+sgvN+jG
	 /exVY5Tsb8hmRL0ipXEWl1ecfUpcbGRrQCSeoRMs=
Date: Fri, 6 Dec 2024 12:24:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
Message-ID: <2024120618-imaging-disgrace-ff35@gregkh>
References: <2024120228-mocker-refinance-e073@gregkh>
 <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
 <2024120622-prankster-lagged-01c8@gregkh>
 <a9d7b248-8c78-489e-99cb-f42d0c735d2d@linux.alibaba.com>
 <2024120646-darkness-catalyze-a74a@gregkh>
 <bdb479e2-baea-4824-89cd-4449c044e441@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb479e2-baea-4824-89cd-4449c044e441@linux.alibaba.com>
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

On Fri, Dec 06, 2024 at 06:37:54PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/12/6 18:03, Greg KH wrote:
> > On Fri, Dec 06, 2024 at 05:41:11PM +0800, Gao Xiang wrote:
> > > Hi Greg,
> > > 
> > > On 2024/12/6 17:33, Greg KH wrote:
> > > > On Fri, Dec 06, 2024 at 01:05:21PM +0800, Gao Xiang wrote:
> > > > > Hi XiangYu,
> > > > > 
> > > > > Just noticed that. Why it's needed for Linux 6.1 LTS?
> > > > > Just see my reply, I think 6.1 LTS is not impacted:
> > > > > https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/
> > > > > 
> > > > > Also, it seems some dependenies are missing, just
> > > > > backporting this commit will break EROFS.
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > Please help drop this patch from 6.1 queue before more
> > > > > explanations, thanks!
> > > > 
> > > > Now dropped, sorry about that.
> > > 
> > > No need sorry :-) just wonder the cases why we backport
> > > this commit.
> > 
> > It was done so explicitly here:
> > 	https://lore.kernel.org/r/20241129074059.925789-1-xiangyu.chen@eng.windriver.com
> > 
> > The submitter should have cc:ed the developers involved, I'll try to
> > poke them to do that in the future.
> 
> I received that email but ignored it accidently‌, I meant
> I just wonder the original reason on the Xiangyu's side.
> Is there something wrong in the production?

I have no idea, Xiangyu would have to answer that.
