Return-Path: <linux-erofs+bounces-2638-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDDnH7xlsGloigIAu9opvQ
	(envelope-from <linux-erofs+bounces-2638-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 19:41:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200F256814
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 19:40:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVjPg5GrMz3bmM;
	Wed, 11 Mar 2026 05:40:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773168055;
	cv=none; b=ls+F9JMJQYFWZQzMzOKv3jFtP3fZ7qTNx927KMfXyPTwemfk+4zvTT9Vss9y5FYi8t2iycMILQPjQkFRE6/eFFTfgPVCi4mT9LkxX1FepNQSUYxYmRICwMFsXFfkzwbc2Ivkz9IbLSOJq8rI0xtocFNHeq4573nqc/awhdNJHvhfr/M1jBYHKxd0eq6tlv5gw0p6JVzExjYbFi8FPylA0JEEBUYbEcTrIfZG1E8Y8fDVJzwvUjL6FCiXLts0ldTeyZVHT+5ZnrJt6BxMywxpKH1hjWO/SZqdjhopP/cRT4uOZf+F6T2O0DpDV1GvdHB2Mtx1RiLlFhr1s8X9G4uvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773168055; c=relaxed/relaxed;
	bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS+qcR0lcd/vUSI428xRhW7YU/PaX09Lvmnw3JTcAy8VxP6vWuoSkOJxDR7uywwFDq3xkmp8/sOf1jrcl1uKG9vwlisqacxLqoMKTnQC22/TQTin1VdSfMeuA5O9OucnPCRUsDtjB8SmoeScYYYr377LRr4t5cxDKO+ScEM7Bd9nK0HvYS2nEdPBpfsTRs5YVaZ7E/J1PFHRT5y+O+gSgH1TXy+1LZIbBYTnsHrwm3YTqnnH1uyEe+3RBxF3BrlTW7+OL4+bWWAleUnhuEn1mr4O+zFbC5gs/qKQ/c5x475ZNwk85vWntxZsQt2qCQg2WVTl1CbZqY6yyl0CNRd13g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M8twsTFz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=visitorckw@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M8twsTFz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=visitorckw@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVjPf2MN2z3bjb
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 05:40:53 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ae88e16485so25594585ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168050; x=1773772850; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=M8twsTFzrqMgm9XPQWXgCjVFWbTrBjUS3aXGVea6sJz19MjfWpUoUqmdxIf84Myxmm
         pOFxN1gqpqcUrVgJPFnU8kC7QTjuROy6/KaR3J0Ti4+jZuW2G48imbYfj482BSQXJ76J
         OHbLj2WYXEyz4EDJhaIkeCeSPSHSyBnuXubJsV1XzHHDNwDEJgDjLWuJ1ep6CN3Aa/dB
         DSlAuIHGEbzgY+uKI6FbKQCJH44DnULYdE+MebFLKWJKaQVb7KrE27XsNPjJvQeVOTIo
         WgE4LDp9yoiR4aS40J6zmGlxe2pRi45JasXNpuMvciZdyVBKGjQJDbxsNDjywYpXJ5eF
         E8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168050; x=1773772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=BOW9i9DMdDm584gwHwNab9DQE8cQvWz0H3ZQOqTHHHSmJv8rt3w6HrxW8JsVUs6iRT
         nogS6gLsl2+yp1+rPL6Po4OQN7H35T+HTT2VZroYb5pCGlOlpZQjlLOKBCmDUMuBHcT/
         m//Kz+V0pRxRtkFUvMcow2SD+3nrcSaUONpmfofGzGKd+GBcJPUuF0V+fuwxMys01r7b
         1uC11ZUdJzWb5Cj3gKwy/Vt/gUuTcEIARG8O+mDZj3MXUZiDzILQpyy157IGjMhYZsMX
         3X6ODSBIWqTJamdhYmTSLhcvZzbu5oPk5Qmfv2+FOFUzq6uDA1lo3QL5KbXrYri3nikm
         3jmA==
X-Forwarded-Encrypted: i=1; AJvYcCU1tkdGW98Ls/DYf8YVjvarI9Zd8oVGQpfb/IwwMMdPnxecvaP64XBkONQyWV0DWlQwPpsICyLewLNfpA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwV0Jb0HsuIxUbahbFQHwaOKy6mPWfS2v0ZbOPTP8OM6YUHbMw/
	azX0Y5Q35B8fyRfu+E2CrC1WURcvwBft3iYFvz+gL9dxHfnTCb1U+PqI
X-Gm-Gg: ATEYQzynRY4cb7cfiQtlFuPcHFSOE7Bl2GGuTcx6snWVAm97QK2I9lAIUxgMtH0+wCt
	vdKF1yk0MTY58/8njHfTKy8zEzEpcMvf3Z90kQNrE1VaO8F6CkG9fzIUJkTIhji35q9Lf8by40r
	I8qzqqyHioi4pIJDqpxRMFf9k4f/36r6FMK+h1LQMsx115iCRc3YZxUAPt/jf3IRJoWNsOsiZP/
	JFois+Xe7DAZj4V15KkdEi9Dt9Yc0F1COZm1F5Jzx9PxROrqWE94BLn91II1QQoVhYS0aOk0v1P
	rF7KK0L8ggYKb61Vz79kvT0yRFzKEsQSmf+CW1gr+rOYbCOfgTw4Pv0QttYpwSiTeWlidVI19N3
	kEm0qEVqYqsD09bDKOh1SC4xxubkNa9BSxnERcoohuQSyTCPRAgvleIJeQQflTqzVpBIWYgxZm3
	mmIVTvCUo91yhrx7+rwTyE892D3Yi/VGtE6zOwF31+IytTqA==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081;
        Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 3200F256814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2638-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[visitorckw@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linux-omap@vger.kerne
 l.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[54];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei

