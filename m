Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27C3D711B
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 10:23:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GYqYz1T59z307l
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jul 2021 18:23:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=e1hWaq8M;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qVvIMDHZ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=dsterba@suse.cz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256
 header.s=susede2_rsa header.b=e1hWaq8M; 
 dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qVvIMDHZ; 
 dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GYqYt5V5Gz2yxx
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jul 2021 18:23:30 +1000 (AEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3F79E2214E;
 Tue, 27 Jul 2021 08:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1627374207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+oMesGkL6U9Ftyv/jPBGc6U/qcAAuGWRvwKofiTqRs=;
 b=e1hWaq8M94FhtLPK9Yqzq1PmLtaUX2abt/VSAxms46a1Pq3v6sVupz65havPR+0IzHP5AS
 F7tcOwNgnVgju3j4baV6stuE6rl+AzBSayg7KC5m+nAFWz/cMbEjTATEufQMtNIvLXK5mK
 IaXHCke87RgJPN5a8cFjLcr67b3753k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1627374207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+oMesGkL6U9Ftyv/jPBGc6U/qcAAuGWRvwKofiTqRs=;
 b=qVvIMDHZE+bbYi9dFvFuxqru7GxUXPmzo4/6Prqj7P5jDqi36kt6f2u2Z5Nw4jjwVUPc/e
 NyyP4uLl9QZjetBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
 by relay2.suse.de (Postfix) with ESMTP id 26BFAA3B81;
 Tue, 27 Jul 2021 08:23:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id EA8FEDA8CC; Tue, 27 Jul 2021 10:20:42 +0200 (CEST)
Date: Tue, 27 Jul 2021 10:20:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210727082042.GI5047@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
 <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <20210726110611.459173-1-agruenba@redhat.com>
 <20210726121702.GA528@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726121702.GA528@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Andreas Gruenbacher <andreas.gruenbacher@gmail.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Jul 26, 2021 at 02:17:02PM +0200, Christoph Hellwig wrote:
> > Subject: iomap: Support tail packing
> 
> I can't say I like this "tail packing" language here when we have the
> perfectly fine inline wording.  Same for various comments in the actual
> code.

Yes please, don't call it tail-packing when it's an inline extent, we'll
use that for btrfs eventually and conflating the two terms has been
cofusing users. Except reiserfs, no linux filesystem does tail-packing.
