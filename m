Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B3988005
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 10:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1727424499;
	bh=l7eXDrSzOGi3k3DnYW9RcbNV1+ltNakNRfv+mQxnasw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=OMQoBoKCkVByMICT0oZbKR1TWzZAtXAnkT28i1qGPuyBH1tyPM3r0cTnEivzJEKxp
	 x1KZPY46OIJYGafCPTMDbDR00/C/X3Ibri47KVPWqQlBwZ51g0lggc6XX13XEV9beS
	 FjOceEUzoU/9dxyjpEK6C/eVcm65OlxrgVI4b1MxFGAFO6xcBW+EDMvWeXo9zfY6i3
	 hvWE2zD0xVHKNf5GUddsrERxJ25Ep2cH9aDQKhrLeifRMmLgUnwNPUgNk5ydwc3JRk
	 xO3FZoYCHi7Q+MqhFpTuP+Z+1HEXZs1RaBGQXZJDNYOH4ybFvRVpSHzETvS+5lnQ5V
	 YmeFMd4ZluNbw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XFNPv4bLvz30Tc
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Sep 2024 18:08:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727424498;
	cv=none; b=BeIGn10eH/mYyYI5CxGF0jIBKF0LDspmmdzkk40A099I66VDIk2QOUL6/5fQhkPTdTkcpupAfNLj0O82mgaAL9wPs+JTDgodT6ki4QQKr3e2prafMx4tAoiNVcHTl+emSQsDpHMtxXgphQ9N4XA2Js8LFSBx6pfglJ4b6LVxaIt6IWgZvOVG4+WmWyDPsNf8ZK6UPX+7gWiUM5GvASPUY2YHKd46UrcmWW3dGciqfJef4hajgu6iMypDmZcLA4r71Z7cZDDDoideugFz5DOp/ajSDIzMGAnuFOnNh9+pAE2UjBPWXTfkdP0P375f0vrHx+MZrSWOt1RjzhwGZuINLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727424498; c=relaxed/relaxed;
	bh=l7eXDrSzOGi3k3DnYW9RcbNV1+ltNakNRfv+mQxnasw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OU39wBsp94NZOEe0sTtQICG4BdmfsdwbF/2a+tRO6oGmkdFLFjX1puAGOrHzG8MtUh7bAyTSHYRE2yhd2qqCIaOedmork5TLKnl99zGAG0bjcxqWDfzHyOMJH9YgPp3EebkjI7HCYq+r5MW109PpO0HSPBOgcRVewfCF2ROYAe3UtSR5yNzNInDmV5B3U3g8fYsZnfRm7jeq1DQ8Z0ZHj1T6ssLqhY9Hzs7C04sYVDidHc0s/Gl7vv/X32FvngfWLotHY5LfpXJP1AtnkJB8ijyVnzLEvUqHHt4q5aTPK/jvFAE7gIpq2EvH5b5zDVieNF2Wz51G0gJGHLIrpWzqiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Outd2lB0; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Outd2lB0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XFNPt2PKyz30Dw
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Sep 2024 18:08:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9A55EA452CB;
	Fri, 27 Sep 2024 08:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C4DC4CEC4;
	Fri, 27 Sep 2024 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727424494;
	bh=qrr8F6mhp37/8goTelXVcSv72h5Emk8kpcyLOVTI7nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Outd2lB01VOTLYDOGeswQwueKzlm+EOifqdxlQ4wB/8MrqP6mZtqn6n+rKIoTqc1e
	 kiisilHVnZCIEJvalKnA3qR2YHOkwk+HzZxQYLedHYLRTpBSFEheAsUMMOVVXFYRgj
	 oZNhoNHLcUvthQxoFMAThjmuiGgHXqnMfBJJboyDD3j6cY2fyYQxHOwaNlAfY9ESKo
	 grEtBzrVEHlyEpt136/mYVhFyRdz36/t+JDZSXA5Mge9d5fwWXYM2cDL4KIrNMeMd8
	 WUGeJbN6K897pM3Cb8O2g8BA94c0wF4P33q9OSZrB7Mfqe5Ls744JoZHQWmwTx2/kE
	 UOLO55iVty1Fw==
To: David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 6/8] afs: Fix the setting of the server responding flag
Date: Fri, 27 Sep 2024 10:07:59 +0200
Message-ID: <20240927-inklusive-erfunden-8a9df201244e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923150756.902363-7-dhowells@redhat.com>
References: <20240923150756.902363-1-dhowells@redhat.com> <20240923150756.902363-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=brauner@kernel.org; h=from:subject:message-id; bh=qrr8F6mhp37/8goTelXVcSv72h5Emk8kpcyLOVTI7nQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9S3928A/vY47APBNFzaQswV4+Pw8Hlu3a9bd+cD9uO Frlc/JtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETyLzMyTNTnfr5xfcZix1xr Tj7JEPepAnKn+FvmbAnf0rfRyop5DsP/gIP2Vf3Nm3a29nDoVNhIl9UaHjpdV197f2eb0M+i678 5AQ==
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
Cc: Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Christian Brauner <brauner@kernel.org>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 23 Sep 2024 16:07:50 +0100, David Howells wrote:
> In afs_wait_for_operation(), we set transcribe the call responded flag to
> the server record that we used after doing the fileserver iteration loop -
> but it's possible to exit the loop having had a response from the server
> that we've discarded (e.g. it returned an abort or we started receiving
> data, but the call didn't complete).
> 
> This means that op->server might be NULL, but we don't check that before
> attempting to set the server flag.
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

[6/8] afs: Fix the setting of the server responding flag
      https://git.kernel.org/vfs/vfs/c/830c1b2c1c28
