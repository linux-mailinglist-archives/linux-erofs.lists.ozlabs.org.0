Return-Path: <linux-erofs+bounces-2674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wORFEPqHsWnkDAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2674-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 16:19:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D3266512
	for <lists+linux-erofs@lfdr.de>; Wed, 11 Mar 2026 16:19:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWDtZ3WF5z3bf8;
	Thu, 12 Mar 2026 02:19:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773242358;
	cv=none; b=mBcYaETVhcEEDtjqJTPQ5NaAMxu6lGj4NLMKZr2ht7wnDZmrH6GlkyQ8j+PgT2N886Rq9/QKUOlD2PW399uC8H6A3paukWd9hyX5JgIe6SCBDvVlm2+/5kbQu3XXM4R4OPqbPUZdfRRFeOVsFwJR03wCsQ1wW2IXGcF8FQ99fUSxUFbFlSDqFjqUPN5hv6OYRe1S5AXSHu2nhtmilqPFk3viC3lJg2qhixKyqGj3o6KymzXpWu661mefD0AR7GMG8SteSfBACehl9O+TcyDtKGNsN66rsWemgYSUKeAxIYst5lJ+g1jUR377l1zUoC0a2u9tounHO1Y6B+cVgMLbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773242358; c=relaxed/relaxed;
	bh=giiOm4nN20bJPCHKicALa9KbdO4HtuSxDT6eKFGA2mo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WTfnOc63fa3Ml3UrfnPC0dXhRnP4TTqKhDyS/uzFEYOHxvHDXbFi8P+NSd/QODon5VHhp0zrwuA62OFtY2EDkcetpiOs47npwjRG++Q/ZvNUv6rgxzeQXeXDGySRbR8SVgcu7sy03yhK9iv+vz0z4PKv1c+1SPL1bHZv1nqgs9WKrSlJudOZxJgaN3AwF8WLnAO8243IjY+6QvqfrHgX+GggshPg9f8qqCCrMHr+Lv0wJYpD8r+gqXO3HeN9zhFy+T9TMQt/aRmTs8od+Karzfd5WQ3QqN5DlGUiOnXCE4OVwLaAGFnzDP49rbLjtMG61LonQcXm3rIr16GoCKThEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=N3vARO2k; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=N3vARO2k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 353 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 02:19:15 AEDT
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWDtW4CFGz30hP
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Mar 2026 02:19:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773242349; x=1773847149; i=markus.elfring@web.de;
	bh=giiOm4nN20bJPCHKicALa9KbdO4HtuSxDT6eKFGA2mo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N3vARO2kWsWkg83YYz1vxwJoQ9jSAIQMxX2vcCM/Stj+o+Wq50UHrg7dnnAtQHuu
	 YAB/z+oy2FKguz0iGD2/h+yNDvP6yvRI3GoGZmMGU7OBxlxuW3NmT9uurD5Q5R1Jx
	 ylayMOI8/tftX2k0W3+2mokAnpBs3CkF8/Do8SlNx13GnuDZ/QjjV5XkJ1n8Oekl+
	 Kuw6q3x1T7SYNU2I5bnMP+ohSvJmogxd9a4Wd3FOJY9DpAzWfAggAB1uysQCkmvhk
	 fJcp5pSjm6VsV+1p7cws9x90+7X6p5CbjMslfOWtHRGXYL7Qq0MimPZqnzUgbwm+S
	 keVIZqyONE+ouVX8Rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cHJ-1vWLef0wrt-00vzxd; Wed, 11
 Mar 2026 16:12:40 +0100
Message-ID: <e6145c17-64ce-494e-a41a-c847df3d999e@web.de>
Date: Wed, 11 Mar 2026 16:12:34 +0100
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
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, cocci@inria.fr,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, gfs2@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Subject: Re: [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over manual NULL
 check
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8uNlJJTAs0E3eVrueF6w+kamgZld8V5k307BMa2qc/KwhoVrne3
 cPN5KceT1D2i5YOSNggwsPxOs655cWyte1CKlNlBLyuH93VGvstvy+ggV5GDmk4PUMu8Iwj
 lIBpLLqKBgo7uQxQM9uBZQLnvS5wa1t6ITQ23zK6Z5KinOA9Ud5Ss1etUILA/92IsKQJLWt
 MbIOhZYtTIg4ZGnA6bYYw==
UI-OutboundReport: notjunk:1;M01:P0:a+IRfFeoX54=;ACwoHm6kjkhwvEQFxocQ2V974B8
 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
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2674-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:cocci@inria.fr,m:Julia.Lawall@inria.fr,m:nicolas.palix@imag.fr,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:linu
 x-omap@vger.kernel.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[56];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 1E5D3266512
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E2=80=A6
> +// Confidence: High

Some contributors presented discerning comments for this change approach.
Thus I became also curious how much they can eventually be taken better in=
to account
by the means of the semantic patch language (Coccinelle software).

=E2=80=A6
+@p1 depends on patch@
+expression E;
+@@
+(
> +-	E !=3D NULL && !IS_ERR(E)
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	E =3D=3D NULL || IS_ERR(E)
> ++	IS_ERR_OR_NULL(E)
> +|
> +-	!IS_ERR(E) && E !=3D NULL
> ++	!IS_ERR_OR_NULL(E)
> +|
> +-	IS_ERR(E) || E =3D=3D NULL
> ++	IS_ERR_OR_NULL(E)
> +)

Several detected expressions should refer to return values from function c=
alls.
https://en.wikipedia.org/wiki/Return_statement

* Do any development challenges hinder still the determination of correspo=
nding
  failure predicates?

* How will interests evolve to improve data processing any further for suc=
h
  use cases?


Regards,
Markus

