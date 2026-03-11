Return-Path: <linux-erofs+bounces-2670-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pt5KLA2sWmesgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2670-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:32:32 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF7260915
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 10:32:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW5BP0Tq6z3ckP;
	Wed, 11 Mar 2026 20:32:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773221549;
	cv=none; b=GA2m3y7vB5G0v0i5mPA8aY1ZypfY0I3K2Aclb2QRucJRXZs2Hye+X+KByyzUXan+Sw7sd1EEO2NmGEGwFFPpb0G1RFVh7/Vax1VwYvYM7DQTEW43Nbnf+3H3K17Ke9jB5P5xC28IMhYBBtdpz23tKWRWYn2cC539IiPQqJ1FcfEQ2pVCIiZhCnUVBDGWw1f+eok5jrtqwL+gjKrfitM7QtRitfChww7xWCrHpf8FGzG7VIZ5WMzQRKxxTrMz0WGliHoc9Q13GCi3kZYuHILRTu2oJgzjf/v/AUd+n8zwwzenQyLaSnaNvhP2Lz4nr2kqKouHWDZuLR/AIqYHCVODeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773221549; c=relaxed/relaxed;
	bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFw+YbF5QMd69l/QY6DXGqbofsOuJimYDfwquIzagso1W8j3uTpE88k3cOP+K1TmrkVdGLu3+U1g3gxBwdqbxPFRDriYvQNSJv90szA3Je10tAvq4Zx4DtGhuDhhNzo1d0PzJeAUsis00GoV3tZI4jTJzkHef4b2o6pXnolahO/OWHgNrD3aDlIdhJJJ8Jg7EGZSFCGa2PM7NToA+sSFvQWKMnAStpyYUhHvXjIfnN6tMJHXTNmoDhnZSStbaGKp0UEau3yhdOY6jNFzFj3uXHpZxZj1r5j383iUDHOaFmpxjtdpdsU+3R88vmob1hSThTcJjVvZnHlIZ1LehHKIvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JfVWEI4z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JfVWEI4z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW5BN1DT6z3cfv
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 20:32:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 091634176E
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF20C2BCF7
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221545;
	bh=JGYhPK256pxU9EiY8jbQSSjgozqR8V5kd9EUseD+GRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JfVWEI4zDrh3iHX+1r4cle8Phcf0RBN0zERjJ8PQNA3EYWSATJ9h5lha/xBvVFGnI
	 lElqdFOyu5rUcg336ldY8JBHZo/CNZ6A5HFkXurPLCqwCA7763w9Gzh1MrCiovz1O6
	 4/dhditNlUPPz/o6nb1awN/pC+8W+SveVLbbW1M3XSJ0LknHbar0z1P9mnX5NF58yX
	 1Uj5dsDyxTrkO1DJZv/qpV8j6iPNzVVJVRqNM1MXMlgjgqpNnn65QlcqD5KydSFEzI
	 yLns3+tdmVfBsvgohk6ekX61JLdkJkatIbZorvb97Pbamw8/hcF79oQl43JkoSoDtA
	 x5H4ornHcPhQg==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ca2b32f46so10232965d50.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 02:32:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLML7wp+5sqpVjB3VVp8hwQjdCOzwTr9pC0ch/teOVp+eNRzh9uOYJZdQkIEMK7c4FeaPOq5RK5Ognqg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYfN4X2nzSOHzdEnBhV+zdqF/d/y9YN1ob7Epf18YqBQsvfb/J
	TRmrSAiLQ8fS8j5qAr1MShpAVwkOU3tP20NKXz5VQH9gOKYSIhPe24nT6WzjIIXMQfjXRMj0l/7
	3mK8vmuDvFX8xJSdjVnOi6/VdfuiO9Mg=
X-Received: by 2002:a05:690e:144d:b0:64c:e890:fbb9 with SMTP id
 956f58d0204a3-64d656f696dmr1649157d50.20.1773221544775; Wed, 11 Mar 2026
 02:32:24 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:32:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
X-Gm-Features: AaiRm52aI8z_G2E4qYaKWPEA43RhLektjwMDQXSLwHd-Xy_BYcin-6heFFY4jM4
Message-ID: <CAD++jLnDv00ErgVdQ4EBpKH9KMWrPD8ODrQ6m846zyQ=wNzCzQ@mail.gmail.com>
Subject: Re: [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C2CF7260915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2670-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[linusw@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,avm.de:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:55=E2=80=AFPM Philipp Hahn <phahn-oss@avm.de> wr=
ote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Linus Walleij <linusw@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Patch applied to the pinctrl tree as obviously correct.

Yours,
Linus Walleij

