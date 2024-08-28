Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB29628F5
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 15:42:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724852554;
	bh=4CsmiWXScsxhSTHVOAU2k2pMHatNvIBL8O5G+Rx1q5Y=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LpWFfTH4LoPq3qm1TJ/cXoTjfQngQYA7IKy/bgBoAZT8WAfSePPLuAGO6MOfd8w7I
	 432zwyuRCZ78kKd7/y7RLHw+b2ZbufKp5fE24xrz5MwGSsE2WOtho+uDA244opqmNv
	 PXiBA13qM1b6MQF7WXHZPiYI4VEDqLdaykNchaQbULREraeVptfPgVUi5O0Ovuahz6
	 y1CoyRCxxdp2yn+zmRR9YmQuts/N1xLOlzFoVxtXIFi39ZX4L64LWIbuBQtpf7ovlv
	 Ys9WSIztgcbH21gYARbYynIteK5Elxyemgg6APsBYBl+Ngl7u6NwhuGAYMQoKheaKn
	 Ga4nqpjQCgFng==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv5FQ1V4Yz2ykZ
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 23:42:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724852552;
	cv=none; b=axemKmfB1gx0lDDBIh/jdfB08SJx8Z5fUcah6DP10SZRk4p/Qb6+FljojIAckZY/jjUz8ASfDpXoRtM0P2WFYfI+8/4x55C96xPTjNa2qgeaIIMnRs9AfNl13b6WRGDzjiS08GKzcjQWLSh70DbzNPYN4UFGNvuTAljb2W5E5uJccAaZtpoz1TBhsUnf9YF83LOWRAQ+pao8SkGxLfcHguAj3ahPYFqOHILKOqRezj5MRItPZvxU1J8Qjgl34XoPSB+FwPBXmqeVQKVsL0ReazA/uYCuHF+aP/gUQx6PVhUdCfbkH4ew8+MmTGWhxoN1YrDkNDSU76ex5oOcPZbPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724852552; c=relaxed/relaxed;
	bh=4CsmiWXScsxhSTHVOAU2k2pMHatNvIBL8O5G+Rx1q5Y=;
	h=Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I/gQfVN0Tn1EdT6DqUgrXajg8BhCktDsE4iLLhaUQBWn5ode5gOsXNLY+VB1Exy8buz9Knb0MfPq1Zg7V0PZh7kENmcv/EJPkE+O9vrWf78p99N3nXEk/4y5mL+mXymqnt9XFSxjMUpn/ZA2YmJoLdDq0zKr+ffozlN6ewFsN8cwGA56TDkgmZc5il9UOdXKujCiEucUni9/2udeGM+ijut5K9K0pUWPhTxu9iyCCk5+vlPz+uAn4Qg3h/COvngBRMuqhx0e2ycCO6ppi4TELsnnE27it5EsM14sGbpet78TKsdGzI9GbPg7eT9n+0+vZfqMJQpYRZOhdv00vRmxNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=izPSZ7ol; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=izPSZ7ol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv5FM6yBzz2xdX
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 23:42:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C460FA40BA3;
	Wed, 28 Aug 2024 13:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E87C55DF2;
	Wed, 28 Aug 2024 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852240;
	bh=Nwfs3yfaGGyfcG5dJ5lnEqC4M+ztIXz0KzLCPLezTec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izPSZ7ol/PohfSmOweUqSXMko8ZTEPHGZfHXUIsi2RP3lpEVM/G+vFKV/ACwpkaS5
	 hFE08LtePrNuFEshcL9aIbQslaCjTwVecGwp2xUVrUwSbBRf1q+iSB8S8uGnGuOnYN
	 icXCLbFhXRF2UaWeVtojUd345KHrrfY/dPbzCbMbvvbJUc+oVVWjWzfM51/dsNapP5
	 MtH0GBOuRLnB3UE/60ci9ZKpIOjCUyUDHgZ148q18YRVitmP2YM0mA7uFp75JaM7L0
	 sQ72IgHlgZt9Dztnc/o8mdexjEKbuQfSTvJVBhRgwmjyDA0occw2qHMKfmDrRaLdEt
	 EvXvFOgLiANTw==
Date: Wed, 28 Aug 2024 15:37:14 +0200
To: Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
Message-ID: <20240828-federn-testreihe-97c4f6ec5772@brauner>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
 <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 28, 2024 at 08:13:54PM GMT, Baokun Li wrote:
> On 2024/8/28 19:22, Christian Brauner wrote:
> > On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
> > > In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
> > > but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> > > deleting its subtree. This triggers the following WARNING:
> > > 
> > > ==================================================================
> > > remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
> > > WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
> > > Modules linked in: netfs(-)
> > > CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> > > RIP: 0010:remove_proc_entry+0x160/0x1c0
> > > Call Trace:
> > >   <TASK>
> > >   netfs_exit+0x12/0x620 [netfs]
> > >   __do_sys_delete_module.isra.0+0x14c/0x2e0
> > >   do_syscall_64+0x4b/0x110
> > >   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > ==================================================================
> 
> Hi Christian,
> 
> 
> Thank you for applying this patch!
> 
> I just realized that the parentheses are in the wrong place here,
> could you please help me correct them?
> > > Therefore use remove_proc_subtree instead() of remove_proc_entry() to
> ^^ remove_proc_subtree() instead

Sure, done.
