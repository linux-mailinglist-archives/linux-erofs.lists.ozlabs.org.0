Return-Path: <linux-erofs+bounces-2676-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCNaNmf2sWl7HQAAu9opvQ
	(envelope-from <linux-erofs+bounces-2676-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 00:10:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC826B327
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 00:10:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWRLB4Y8nz3cDg;
	Thu, 12 Mar 2026 10:10:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773270626;
	cv=none; b=M47sHOXdIIpy54wYOc11zosLvSqw4woAIgoenteQEL8e2nylmpjV3w2bKdlgs+ZG8qu2pSYTUJp9G97zLEnji6IhwWV3EBEimHLDU3y0oBxcAdyy+5y2pLpRTmoJsGkIlEIc59+C73WoDJApvJsfJJ2H9Wj8KOUfPMgQyBTPzQ7FpCNndm06XHamSkudzHJPtbvYGJojKfXFZndSFngU0qcMk6m5XRnC99ubJ0hhsczmWWu3zHfWdQvZA6bdR1mocyCH5eMLzZtbRl4RiRlz+UDYtf9NMVVq6OR7OFw2cPG16aegK6/MYezOYxEz7T+/y7qfrpnG4K3lJirpdg7HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773270626; c=relaxed/relaxed;
	bh=33EAGUBLBYod3tzyGg7m09477vqXsAXQIQrUfRFHjU8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=MHIfn0YX+KjsXifIRihvkbB/SzLgMZfdRL1UU2aGn2dVRjKiqCxHwKc+xoA6bikLPLBcSpL2V7Wn+mNBdrm0MbovF3rtAMDaEP6WTHUlYyk/9obtyqjXjW2YgK27vdDtS2XkWRRpcPgquyjhxR2JvDtWzL51RH/AeTanpptRh72lhK6jcxzIvWgL/oOoWlTSk3uWH8BKRykjXelhYBgSsH912IoBPFw8VUE8kAYYvNj4lQfvrJvibAFpXVC8oHaOAyFNHqR9vf76P3PO84vflSsgSc96iPMdJs3ThRfCyTvD7+Mf2IY6RPo7SbgziezGvkoGipQcJikfLapDf14GFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; dkim=fail (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=WxcdvAR4 reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=213.167.242.64; helo=perceval.ideasonboard.com; envelope-from=kieran.bingham@ideasonboard.com; receiver=lists.ozlabs.org) smtp.mailfrom=ideasonboard.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=WxcdvAR4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ideasonboard.com (client-ip=213.167.242.64; helo=perceval.ideasonboard.com; envelope-from=kieran.bingham@ideasonboard.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 402 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 10:10:24 AEDT
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWRL80Qs6z3cDf
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Mar 2026 10:10:23 +1100 (AEDT)
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD91E448;
	Thu, 12 Mar 2026 00:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773270149;
	bh=ATo3aRyKmYSXuSYD8x/NeBUp5LJcLKbzHVpozNXQJC0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WxcdvAR4zphcUuTNTLXCbLGiiCOKCwemLRMbnRdmW3ARcBHAWQiYVeysDpnfCIDuk
	 B8rMCjKjDjoWJdgj4Zp0scfHxrPnr5P3xl9hFANY/wyWKZBZYHzyf2qsFxVEe9S31Y
	 m9r/HjFnopry9bsUUdk6/id/Q3d97jYK/FiMa+Qw=
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-49-bd63b656022d@avm.de>
Subject: Re: [PATCH 49/61] media: Prefer IS_ERR_OR_NULL over manual NULL check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org,
	ceph-devel@vger.kernel.org, cocci@inria.fr, dm-devel@lists.linux.dev,
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
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-phy@lists.infradead.org,
	lin@lists.ozlabs.org, ux-pm@vger.kernel.org,
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
Date: Wed, 11 Mar 2026 23:03:33 +0000
Message-ID: <177327021364.3167621.11851238159935183684@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [3.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:lists.ozlabs.org:reject}];
	R_DKIM_REJECT(1.00)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[ideasonboard.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2676-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skhan@linuxfoundation.org,m:mchehab@kernel.org,m:phahn-oss@avm.de,m:amd-gfx@lists.freedesktop.org,m:apparmor@lists.ubuntu.com,m:bpf@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:cocci@inria.fr,m:dm-devel@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:gfs2@lists.linux.dev,m:intel-gfx@lists.freedesktop.org,m:intel-wired-lan@lists.osuosl.org,m:iommu@lists.linux.dev,m:kvm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-block@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:linux-btrfs@vger.kernel.org,m:linux-cifs@vger.kernel.org,m:linux-clk@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-leds@vger.kernel.org,m:linux-media@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-mm@kvack.org,m:linux-modules@vger.kernel.org,m:linux-mtd@lists.infradead.org,m:
 linux-nfs@vger.kernel.org,m:linux-omap@vger.kernel.org,m:linux-phy@lists.infradead.org,m:lin@lists.ozlabs.org,m:ux-pm@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-s390@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-sh@vger.kernel.org,m:linux-sound@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-trace-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:ntfs3@lists.linux.dev,m:samba-technical@lists.samba.org,m:sched-ext@lists.linux.dev,m:target-devel@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:v9fs@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kieran.bingham@ideasonboard.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kieran.bingham@ideasonboard.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[ideasonboard.com:-];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,avm.de:email,ping.linuxembedded.co.uk:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 75DC826B327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quoting Philipp Hahn (2026-03-10 11:49:15)
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Shuah Khan <skhan@linuxfoundation.org>
> To: Kieran Bingham <kieran.bingham@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/media/test-drivers/vimc/vimc-streamer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/me=
dia/test-drivers/vimc/vimc-streamer.c
> index 15d863f97cbf96b7ca7fbf3d7b6b6ec39fcc8ae3..da5aca50bcb4990c06f28e5a8=
83eb398606991e9 100644
> --- a/drivers/media/test-drivers/vimc/vimc-streamer.c
> +++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
> @@ -167,7 +167,7 @@ static int vimc_streamer_thread(void *data)
>                 for (i =3D stream->pipe_size - 1; i >=3D 0; i--) {
>                         frame =3D stream->ved_pipeline[i]->process_frame(
>                                         stream->ved_pipeline[i], frame);
> -                       if (!frame || IS_ERR(frame))
> +                       if (IS_ERR_OR_NULL(frame))

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>                                 break;
>                 }
>                 //wait for 60hz
>=20
> --=20
> 2.43.0
>

