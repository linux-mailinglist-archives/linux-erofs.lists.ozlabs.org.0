Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC1F6DD540
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 10:24:16 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pwf5967rYz3cNJ
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 18:24:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1681201453;
	bh=6nX5sI6EN+QIsWtAaq5RhWz/W4vuyCGzISy2tTv8b6w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hRiNTFhXVS4Ha9Tl/gF08Z19iL7pj/2sCXajJASfX5niNawWrHZGPeVNImHmWVbWH
	 5ecYYRW9oPq4Uq0spIYzd55AuPM8/TE5P9YD9dCWsolddvqy8JrQxBrfyRZLmHPe+r
	 29dB86XBmrcEnHk/Zty2bSh+AQjumGmNh7jWVAOVr31GCnsdv+hcxg1CUvmdQQjYP/
	 UDneVOs0uOYrFzThHjNzZWSn9i02iLsziQZM+MGx/5o9lYX4g72gCCIKc21FT2Mt9U
	 O+ASjeS0i4wMKg6Fj3gH0//gRIVrjwwtJW9xaPdSvB1Jtn4JNf9atwijej9NAlZyjJ
	 9plP4yr59YGYA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+c6fa32d9e84a85109083+7170+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN>)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pwf4z29z3z3bTG
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 18:23:52 +1000 (AEST)
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pm6Py-00GReU-09;
	Tue, 11 Apr 2023 05:19:46 +0000
Date: Mon, 10 Apr 2023 22:19:46 -0700
To: Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH v2 00/23] fs-verity support for XFS
Message-ID: <ZDTt8jSdG72/UnXi@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
From: Christoph Hellwig via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christoph Hellwig <hch@infradead.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Dave is going to hate me for this, but..

I've been looking over some of the interfaces here, and I'm starting
to very seriously questioning the design decisions of storing the
fsverity hashes in xattrs.

Yes, storing them beyond i_size in the file is a bit of a hack, but
it allows to reuse a lot of the existing infrastructure, and much
of fsverity is based around it.  So storing them in an xattrs causes
a lot of churn in the interface.  And the XFS side with special
casing xattr indices also seems not exactly nice.
