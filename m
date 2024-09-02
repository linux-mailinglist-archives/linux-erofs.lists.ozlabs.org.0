Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2496836A
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 11:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725269818;
	bh=EqEGzAiSFpj6BRzXs2WVH89o1of8MQ5nzTl56kfrrR8=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dUSMZWMuGFQn6NrXsyidBUtec3obyZwbYFz24nmzVOB080WasnMT5xXG3y+o+loel
	 4le6Ut5GD+CUYiYOZhCwr4Lu6QG6mGXINdvOn+SVSW4M4QDTM/IUcE1ZV4EwG195Nx
	 H/PLWE9PxtaEtrFLhydhGM8EQgyetV2At2261GTHaksUp64RjUNGi4thg1mSdOv45F
	 BALxGlNZnka5DiC0eHUfpJRO92HlTpjx39gEOVZXdL52AwRxZMk06kR60snZSVhQb8
	 jRsq+tjH5Uzkbm26Sb7bRD/+5EzzRFCsICbbvQd4eAEevfG/zVgSbgeHJETrCj6bOf
	 g8BMsofGw36zA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy3Yk4yNDz2yLV
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 19:36:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725269816;
	cv=none; b=ZWG4CMYRDBdrWlLHIrOFgEb7Pkj8kFZ5dgWyAiIe6wVp4ZYb6sKr85NX1P3ztHd6gwd7WwyCJh9ku1o6hnJOKmzDhrMa2eJA6max7wYLIDhXpRMLXb49kr3xn6XI863MeRA2cwOmk5p0Uh+NGgw1CvGPSVRyjfOkG2SJB5w6ZUPCA+k5nB+wbL9WM7u6WwjCki2J8nTDsyvIjmuIzicj2a8l8gLgNva+dVmgGefZtNdrCedQCGur2npl2klm4zOBVnTjq2O6zTaRDoPvLb0MIyndbauDzWB+jbzZogWSJhhEQBs/Hlcc/6ezvRvZIbfPbhhhkiIT73cR1vXdmW/3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725269816; c=relaxed/relaxed;
	bh=EqEGzAiSFpj6BRzXs2WVH89o1of8MQ5nzTl56kfrrR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfD1yMJhw4D2xkEPd5R3GJ8xg1zRsXfEmREDlVrQ9KK9Wz6H5eKHZgXSJ2blI5cUrZ75K04CPuhlptEERoUzCAqRPKWmaPNMkxKwkIHvOPb9RASdJhc7uiqM2LgyS2A2Rs/mCmO+Z7ttexRW71QkrWQBis5t3b7mt1cBx/nj9zM+fAB6UnHGR4ent9ZkmgSdg4r9lw1Z4Tzg2erEa5IpgbCNm2DcJq9jHYX3bFEUcLMvJ3Psqxd6yPmnfpAZScZMGNEF7g+UXvb5V80XIqiqKtQIh3gZ1qfH7yedAGtq3+M/6DRWGUjrUoicMXyGWkWPuPvWBQqenj4juVTVgJtHZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=es0FvngQ; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=es0FvngQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy3Yh46D1z2xZK
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 19:36:56 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39EAE6983C;
	Mon,  2 Sep 2024 05:36:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725269813;
	h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EqEGzAiSFpj6BRzXs2WVH89o1of8MQ5nzTl56kfrrR8=;
	b=es0FvngQszJgDVQeFkoupklBku32Kv6QHNpv43O/egwQufhYhjLnrkf/mvaS5Tjs9elqtT
	KNkU5j7JzQuUYxX934RDkWsiLG4fnq5MCXXpX5zDiSPojOzfHvXTLGRjkw3ALstI+eNVFd
	4orPj67gx0mgUl1HPMg8cbCkv1voNJqzZd4qThczllznSrmYc2lI+I7k1l6EFWp9binNd4
	rbZAj+HUSFR8ek06dIT29/T1mTgDCE4dhaZ/xRBwU5ua1DKAc8cw4oVv/gA+jvt0aySOdA
	5iLG4Y97OXMAz1AK8jc5LUWaHPVVa0K0ypK44ScCC8QEhW/IHauo5l1ElaBaNw==
Date: Mon, 2 Sep 2024 17:36:48 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Message-ID: <3qxpexpa6gd2yc2ez2miar2vhdswbj6juxc6zdawyktpjorwds@mljzzugbspxc>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-3-toolmanp@tlmp.cc>
 <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 04:53:02PM GMT, Gao Xiang wrote:
> 
> I don't quite like this new line too, since
> it's already simple enough.
> 
> New line is used to seperate different logic,
> not just different block.  Yet that is my
> own perference though.
> 
I have refactored all of them and rebased the patch to dev-test branch.
Please check it out.
> Thanks,
> Gao Xiang
Best Regards,
Yiyang Wu
