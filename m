Return-Path: <linux-erofs+bounces-3146-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IA7GQsDzGljNQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3146-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 19:23:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E136E996
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 19:23:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flZhL3XkGz2yfK;
	Wed, 01 Apr 2026 04:23:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774977794;
	cv=pass; b=STazGs2SkkA2H60b689ordPtsBamxy+mXEsU9b4ykM2KwJVsgDaPLmtdBssr4eZoggA5+ySziwf5UbVbEgdiOFoWEdpVbWmmkuvarpImr9atyeR5Y04Xg0JXSIGdjDBL8TvWIYGzKalQCyeo3a0dy6+4iKShyPd6RwBZj+jmtT3AkUJKzR3VSYUkJkM/S234UiCUxsNeYZ8pdETbVMB60qEhWWgot3M4bfXs3XpzimcZfULysuRiZfzzCqbAmmYfHZiEnyhsvSBv/txkzjDXg+8XWO0VZZ/yYGDonho2kBSWJ16H+FREQGZpqh/bc3h/s7zS/islLtJ6Mz2ldd8W4g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774977794; c=relaxed/relaxed;
	bh=s45MsvRbiRiVvZUd+lkTR2gyJQ0poocb3cgflxbIQmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PiT1LSrgoxYpl8N/fGOA4eOwg/iMjctRw/Qu1savUrOj1n0pUNihBqWI67lRM71Q6+rUF+DYhP1KE7r270v6WrHivnEDQ5eZrdkrfIdLes3FA6t78pPMK8NGWtqG0GLOWOQbDzXvPlfjmf5ij7NoUf5z2Nt7XfoDXp8Nj5T5b1aENl+dOQmTFP/aSyP7MQea36SeWuMWl5fuS2ej60/qtOgAWBXrafCppUG72B8ohXBfvG7Bta3yYA27WF7wsWjs/eNiHzIvijshMNFwz8rSYiAqzQRRETqrN1qXXYhehv4UkjRMw98BsBw5kFG02mCP2ZVwNc/tK2Pc/8sLbCbvfA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PcaPaVDd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=bushrahz.giki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PcaPaVDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22c; helo=mail-lj1-x22c.google.com; envelope-from=bushrahz.giki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flZhJ5kDGz2ydn
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 04:23:11 +1100 (AEDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-38bcda08c76so47930041fa.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 10:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977783; cv=none;
        d=google.com; s=arc-20240605;
        b=RoMG7OE3Iaqc1UdVtOBmOGtjEdf7H5rIn4rVbJZek8Mxy7g6BtFiFIYtpBAikY1OK6
         3Z3JPaikok0hkJrhEF6NX6EL1DF5xJPguvGqSlUcGQ0kV6bvoeWve28d2IzGOFOftYiB
         JVn3unf+6UBmnRDWtrUB0+muqScuQfKHAcBMn86sBC5ieKFxegTA7aJtcA4lDva/xffE
         WHcdgZ03EgCVZBGtgXCHkuvro8CfAKQRMmw8DG7e+m2lId4J0oVRjXjDbsJKRGa5bFPR
         mrWpgOCL55qjOMyMPCFC5nio09biI3cxM/EoH/rsUG1jfLzN7Lbpd/fBKs6MmgFai7qT
         /Qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=s45MsvRbiRiVvZUd+lkTR2gyJQ0poocb3cgflxbIQmU=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=XbcxLzbV3lCnvyysNSWvbomS173R6c6kSz+qb4+VCC82xFnhaB6VNPrFmD1/ywQ3ET
         5p9sUK7YENjrXisVUR46/SQPXAS9zQJDs7gCoblb0XEzc1Vgrhw+nVwcMBr5M0uaZlvB
         de564Z+dWuFaKBbsb0OySTUbLkWNDsT3FOV70bx4yfCttXLuPfmGrtoFQCY6FYebbjyt
         E4aq20oy+IGLd/52AI/F2ascO7rbzPJT3Q67ZZNfYF+mePtKb9Db2UKICo3QqzVa8JPg
         pWTySQRyynh13vZ2o90nG0nVnEZT0282a7UPny1KmWdfwiVoXheC10UOGixzCPUIhn/E
         IBDA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774977783; x=1775582583; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s45MsvRbiRiVvZUd+lkTR2gyJQ0poocb3cgflxbIQmU=;
        b=PcaPaVDdlkgdWu+ZZERsCNR1xjsvT3sW9AuWgNlVjsGpvKxXRbBuma9KOt+RIE+r9o
         LNusfhs+PxxJWiGiWvnw9t6nFSBCmj9A8+43mo9Q683xNJscvWiQrzY1X2UxuhPbKPPw
         4yt0zESQDg54ZF4l68t4bpiWSM9VuWDwxWRCHGdrwxFpNedWK/Yp3oYxr0PlTiGggr1t
         xplruV+0o7bgvw7hU3B99zyU+sGISZ4ZELXafyMSXLqHvuhXCdtQSj/8t12l0DgQsISy
         dT7ot5PL/8kwcEwZcJmc6n0UNAucFoIApxpyqWk9OMxkOrkAwIITKxeVmj6uutEMfmQM
         MsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977783; x=1775582583;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s45MsvRbiRiVvZUd+lkTR2gyJQ0poocb3cgflxbIQmU=;
        b=FGkVKTCF4F9w2yK4rLvE82Kv0dUPHfBoiYRkZbTE0yjaFwzCmCb0j2uJaSjkFB9Ld3
         KKtxhziBXca3yb7f8VDsT4Y7sQLisKGLgUYV9JgEDUiUQA7OOR+7I1JG7MxLP9FLm0Hr
         4D70EQHafX6QgBtaFq7loOlJgAwoL6MNRu+AV9+ZFkCUXyHHl+UHigKx4XLSBR/mK8ZB
         GYxwFmfVU5rDcQ2KTB2fjnwFGkCHHLRXWnK24SCTOJ24+dASxi7fg9TN+E55swXGmtML
         gjRuG7Rb1DqXDYArA7GFH7iX+wBlnjheRI4bo5YZj+k3Vo4CVsyUXu4zHqM4HFHRjssX
         seHg==
X-Gm-Message-State: AOJu0YwznxIHcGZGsHU/Z+3mDfGrx5ec6XDOXVDrEELgDPO7gLPnh54j
	lU4vgZCdQCfuR5BLUWPy8nGC8BgPMNwipWhSYLo2/cL/diNuGYy/I86H3seUrIDmngNxEM5iMqw
	gF+eHnE0srg4EG9JA3azsK2qEG8hDn0t/1zy7164=
X-Gm-Gg: ATEYQzxWleHxhPyCPux/2/gALkl55CPqoAQZm3Aj0mfIoy6K5Rt+sKj2wEz18pE0W4r
	72ty3L/RT8Ho7Jg+CWOASFMms8WSz1AnwGgdVhuAsVK/bhi/F+xmRfFVOy/r5F+5czgOvyyErf4
	CwJgR7IAfFfasnhsghYK1aM+gfG8zDvMMRrakFMTSC/3nRySHmCNcZ+3ICCFaMjap/6cajJvMPU
	jMVZNa5QvQ70DshKMZPucGqSdvrm2WYZbc5ZkQp0yDJddXtpBYY4iDdKiIhisN+VhGL2b+dDXJv
	eIeWY5IzWPq5zA==
X-Received: by 2002:a05:651c:41c8:b0:38a:98fd:d7c3 with SMTP id
 38308e7fff4ca-38cc3160da4mr538031fa.34.1774977782370; Tue, 31 Mar 2026
 10:23:02 -0700 (PDT)
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
From: Bushrah Zulfiqar <bushrahz.giki@gmail.com>
Date: Tue, 31 Mar 2026 22:22:51 +0500
X-Gm-Features: AQROBzC1vKCHVIPA4L9MnhWT5VtHmv26q-p4Q4V147KBh1is5uyXywvdFTKj8T8
Message-ID: <CA+ug3id4+QYbqTFzaMB_9LaE1HivfA34jGj4FgbOKwq94MFVMA@mail.gmail.com>
Subject: [GSoC 2026 + PATCH erofs-rs] chunk index (8-byte) layout support
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000033d636064e553868"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-3146-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bushrahzgiki@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 670E136E996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000033d636064e553868
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm applying for GSoC 2026 for the "Complete Filesystem Feature Support for
erofs-rs" project. I've submitted a patch implementing the missing
erofs_inode_chunk_index (8-byte form) parsing:

https://github.com/erofs/erofs-rs/pull/5

The EROFS_CHUNK_FORMAT_INDEXES path was unimplemented. This adds ChunkIndex
parsing, hole detection, multi-device routing, and a map_chunk_offset()
resolver for both array forms, with full tests.

I plan to follow this with DEFLATE and Zstandard decompression backends as
the GSoC work. Happy to receive any feedback or direction from maintainers.

=E2=80=94 Bushrah Zulfiqar

--00000000000033d636064e553868
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hi,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">I&#39;m applying for GSoC 2026 for the &quo=
t;Complete Filesystem Feature Support for erofs-rs&quot; project. I&#39;ve =
submitted a patch implementing the missing erofs_inode_chunk_index (8-byte =
form) parsing:</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]"><a href=3D"https://github.com/erofs/erofs-r=
s/pull/5">https://github.com/erofs/erofs-rs/pull/5</a></p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">The EROFS_CHUNK_FORMAT_INDEXES path was uni=
mplemented. This adds ChunkIndex parsing, hole detection, multi-device rout=
ing, and a map_chunk_offset() resolver for both array forms, with full test=
s.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">I plan to follow this with DEFLATE and Zsta=
ndard decompression backends as the GSoC work. Happy to receive any feedbac=
k or direction from maintainers.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">=E2=80=94 Bushrah Zulfiqar</p></div>

--00000000000033d636064e553868--

