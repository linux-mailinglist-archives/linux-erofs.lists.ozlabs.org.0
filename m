Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED54987FFA
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 10:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727424372;
	bh=w3tgcr07l48NUpiRId4iNl4o70xksvq/UJEdOlAXpiA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I4Usd7VC7UB+sc/TJbdUnqKk/5bAvDpVLKrpLxpb5DWMfwkPA8yLAXqj/GxMsPEPA
	 GVhbPjVf+bOMbDA5aDhz4MuVK74UcdgV+ySEwh/njJ5EnqAh0pMQf34FSPHdoj3fCO
	 dx0FMTwUKl3ZZEpGgl6rXzdJL/a70OMQR5f9nNHUSYkSIDDkHAvRhTvHNKvP9fFoU7
	 /xr/J2DONpo6z2w5G8OM+m8rVCxetxYhkzdjxqvuqvFl6IQnF487Z3RblrGm3ZrhJu
	 QDhF0XMTic259VItBvE0ouN52WboLL22+f6OkV10gD6dw+Zm8nn1w4Cg7DgOnpONpI
	 u9pjKKQffkndA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFNMS157Lz30RN
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 18:06:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727424367;
	cv=none; b=hW1cBqICljLWEAWysaFcwzJt07r8K5qSCHBPwErJTFDLSaZxZlW2jH3BU0HWsbICOPVssl4rGZ+favlD9bcpbBgNkxz/cuS7T8STPThdSuGxK2ELn2ag716fy8DjNZw81p5CKMkG9oV+pUrn6T+LStnrhyG9FEyCV+n9goVShwqTy6wUFWLd71FoWSBKjNhnO/LNlYmrn/Hrk91TLsUdst4Oa5UdF/AQAlYknD9kD5+O5yu4ZXWgqTYyx8eWH/EkAgrOO7UZ2JyzgYOGPZAqjLupCtdx455XzO6vUAGTnE0I6UlhshC6a0Utrxd5dqQ8eK8Cu/HwddEgozaBh6MRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727424367; c=relaxed/relaxed;
	bh=w3tgcr07l48NUpiRId4iNl4o70xksvq/UJEdOlAXpiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsXTl/p6g07w0ltlti+dDolnNdfpfONH0ZgvCsyzGZcm+qcOSH3gTbheKs9ut+JBXv3lxgAYasQ+ox6Cxqaq2CWjO7r7DnFp7mqP1pzsnD3azsyOgjQ320zJMHGNPG+UhLjTHA/ncGNGRRPavJOhWu53xZEd1jM/FRD4sXLpyPSV4y8R3g1mkN6Z36DOz+iXZLvmeSfyyl29ZRQxsG1BSjY9TurdAApW8cvltt3duA/uEG3uJCeiqj3ljBvdJ9pqV2giXGhA/N3fKk4Ns0OHKDTDAWNA9VKsvoZh9nL3uJvQgwIqjw/cNOVn5pm8DRuDOPzm+6QYeAy5kOXqKhSb8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HaAIXMic; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HaAIXMic;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFNMM42HKz302T
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 18:06:07 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E28A45C5A4F;
	Fri, 27 Sep 2024 08:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8945C4CEC4;
	Fri, 27 Sep 2024 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424364;
	bh=KjsjOpufVwVtvtG9C4bCus2/XmKmDXOmFJWmSRq/BY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaAIXMict1VrTe7i8TwVZ5W3EQ/WTegi8/OHOEkwPr173UnrLezn4mPejbmDGj2Va
	 JzClZWAAEFXfx5vFVFkjx+3Bkn30tc+SssdrENLR5FslHOsVouXCdLzMO+adoH9tnc
	 zkXNylEWRwKw5LUIOdH0peE5GHb2oq7StB/T/R1ZqX2rjLg3gyt73TQdT9CGlK1e1y
	 +0R1PmoplUYpYy45bYv/DHBqbVebHLvqJ+Zj3yrLJO2EGsPMgBdMR6uK6DZ+/mXWG2
	 BnuUyJDVL64zGvygjtGlvBwmLB3O/DZn15DHVuse1YXw/gPPN/DLf8Erpw19GuMUJ6
	 BIWbB7FwYdy7Q==
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 5/8] afs: Fix possible infinite loop with unresponsive servers
Date: Fri, 27 Sep 2024 10:05:44 +0200
Message-ID: <20240927-raunt-gekrochen-aa4fd2c2e59b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-6-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=brauner@kernel.org; h=from:subject:message-id; bh=KjsjOpufVwVtvtG9C4bCus2/XmKmDXOmFJWmSRq/BY0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S0+55/AnN86X/6qh8Jnw2/fN3txs/vdb88Csxor51 h0HFWpKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCv4SR4f4hM23PS4ZOM4SW /uIJzdp91vHK3XmrQzc7J2s8lPYT0GT4Z2t0NERa9/mHUpZlb9KM7mza0TV9pafR+8KMuYvUDR4 GMAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
From: Christian Brauner via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>, Markus Suvanto <markus.suvanto@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 23 Sep 2024 16:07:49 +0100, David Howells wrote:
> A return code of 0 from afs_wait_for_one_fs_probe is an indication
> that the endpoint state attached to the operation is stale and has
> been superseded.  In that case the iteration needs to be restarted
> so that the newer probe result state gets used.
> 
> Failure to do so can result in an tight infinite loop around the
> iterate_address label, where all addresses are thought to be responsive
> and have been tried, with nothing to refresh the endpoint state.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[5/8] afs: Fix possible infinite loop with unresponsive servers
      https://git.kernel.org/vfs/vfs/c/6e45740867ee
