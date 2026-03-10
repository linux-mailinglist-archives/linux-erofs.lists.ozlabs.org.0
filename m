Return-Path: <linux-erofs+bounces-2635-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFX8Lzo9sGmohQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2635-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 16:48:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41244253EC8
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Mar 2026 16:48:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVdZG4KVTz3bjb;
	Wed, 11 Mar 2026 02:48:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773157686;
	cv=none; b=a3A6z7ayM7Xasp9yRwiNzXn1zX+7F0oWiB4i1z0FRndIR1P6Ga8Hl60lvx9PHOwIiUSQgKhyxE7ozOVxPGo8/Is0yo39cSJdBjdpy4mXEPfu7rexcGxG0f3GiIPZOG8ZAOv9SlLxrV8zMbanIX1xqHJSstynH0SOdZrVS0lvcwyCb3ITKvNPdGQkxhJ5W3dXAMmILIdDhyTxXGFV5ie80/NhVQofvl3y7oMQ0li/3yWw49QBam3P3Yfvk0d5nOcpVrBjbPPjtK0A/jywAF5DYMQq067qPQd5UwaV0ZCtE6p0FvJMwdY14Y4UIQMNsA4xn6+Fcx74pDzB6+Vpn2qmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773157686; c=relaxed/relaxed;
	bh=ViIdeWt5br4rBsrGxHUMEkJDkD/ERSvSv/UV5SzvttY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=fKc3duTEzRB4HBn15YfDUaElbOsYaRIEW6ndsRNV18shfDmA8WYRn0PaHId1DgfsCi0A0ge+yl2NvEwmzS8qy7SXjX4e1dOMZsGFb6Jx2wn0e01QV50GjBG9Dnlcbzjp6eoNAxF7kYGpKqnCuLAs+2bJcgPnIEYr/VCUbjbspWAtHZWASDO436cFMcMiAqlhxrTF3cpboh2tpFzrbliEyZSX1TBNoxMSdDgc5Gt5Ega4meXtZxceMvphTs97qmg/7+/0OQRnAunlrACnJnEwYSMNU+J/i9uTXekeLYymYpi3R/1kRWYOPf41ORDzJIy9oAf/cms8D/bG6g21l3t31w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=h7K0qFC8; dkim-atps=neutral; spf=pass (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=h7K0qFC8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 365 seconds by postgrey-1.37 at boromir; Wed, 11 Mar 2026 02:48:03 AEDT
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVdZC37rXz30Lw
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Mar 2026 02:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773157662; x=1773762462; i=markus.elfring@web.de;
	bh=ViIdeWt5br4rBsrGxHUMEkJDkD/ERSvSv/UV5SzvttY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h7K0qFC8lui0M3aEG2yhHOptmzLeK24S79cZCRktla9iVPsdh7MMZY9IQ+0fNsjy
	 1Jmj8tPDjUYGV0N31jChpPIbrmEGAAiLmOFKWubyE3NTttjDE8UYZYzPrHWHwqRbT
	 ZmJLoNHR6+mwIgea1XMDsroKD1VkpdbtDpYP5RQOlLeXbFM1sGNyCjcqO4VGv6oH0
	 or7WNvOJCD7wct+ITkk6hEn2pz09hvl0HnH1IXkz/NhmxM4+GPG6PRDdXRWJwhNqD
	 E/CyuUCmqvUAopwe+bMtAzI3unk/5Tnu7dsxuDhsN1+B/BFgi6IvYkOUfIHgIX1fz
	 IDA+/KUXvW7fGiboiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1vYM6w3zfn-012TrV; Tue, 10
 Mar 2026 16:41:18 +0100
Message-ID: <924acf71-45df-4ea2-9bbd-b6f5ff262b2b@web.de>
Date: Tue, 10 Mar 2026 16:41:12 +0100
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
 Julia Lawall <Julia.Lawall@inria.fr>
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
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 nicolas.palix@imag.fr, ntfs3@lists.linux.dev,
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev,
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 v9fs@lists.linux.dev
References: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Subject: Re: [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over manual NULL
 check
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I49ufsxpBKiFBze+2Qm04f+elx94DZSymOaZcQTAnyd9Dy18WSZ
 l5PlqGBdCeQJnqXYHB7LM8JEThQzWaqt46DhF3JOnbIEKCtwYJeZnzJMAXhMu3h78zedo+b
 2MDr9yfDF5xiOPbOsnoVg9HvEpZouoV7eAA1AasOX+/8mAaWp7eICgl3FZXuUGMMgTPEUmo
 9zEXJmftCILFnPJ5epBUQ==
UI-OutboundReport: notjunk:1;M01:P0:04WXpfHKV24=;XM8484Tl0Gel7LmfPFVAhD+GUiz
 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
 WH56U++o=
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 41244253EC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2635-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phahn-oss@avm.de,m:cocci@inria.fr,m:Julia.Lawall@inria.fr,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:linux-nfs@vger.kernel.org
 ,m:linux-omap@vger.kernel.org,m:linux-phy@lists.infradead.org,m:linux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:nicolas.palix@imag.fr,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[56];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[p:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

> Find and convert uses of IS_ERR() plus NULL check to IS_ERR_OR_NULL().
=E2=80=A6

Can this information trigger any more consequences on corresponding summar=
y phrases?


=E2=80=A6
> +++ b/scripts/coccinelle/api/is_err_or_null.cocci
> @@ -0,0 +1,125 @@
=E2=80=A6
> +virtual patch
> +virtual report
> +virtual org

How will interests evolve further for the support of the operation mode =
=E2=80=9Ccontext=E2=80=9D?


> +@p1 depends on patch@
> +expression E;
> +@@
> +(
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

Did you eventually check probabilities for the occurrence of mentioned cas=
e distinctions?


> +@p2 depends on patch@
=E2=80=A6

I suggest to reconsider =E2=80=9Cside effects=E2=80=9D according to the sp=
litting of these SmPL rules
once more.


=E2=80=A6
> +@r2 depends on report || org@
> +identifier I;
> +expression E;
> +position p;
> +@@
> +(
> +*	(I =3D E) !=3D NULL && ... && !IS_ERR@p(I)
> +|
> +*	(I =3D E) =3D=3D NULL || ... || IS_ERR@p(I)
> +)

I doubt that the usage of SmPL asterisks fits to these two operation modes=
.


=E2=80=A6
> +@p5 depends on patch disable unlikely @
> +expression E;
> +@@
> +-\( likely \| unlikely \)(
> +(
> + IS_ERR_OR_NULL(E)
> +|
> + !IS_ERR_OR_NULL(E)
> +)
> +-)

* Would it be nicer to move such SmPL code to the end of the patch rule li=
sting?

* Can this source code search pattern matter also for further operation mo=
des?


Regards,
Markus

