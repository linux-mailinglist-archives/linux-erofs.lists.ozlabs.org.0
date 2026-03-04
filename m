Return-Path: <linux-erofs+bounces-2489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NxfB93Ip2kZjwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2489-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 06:53:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E191FAFCB
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 06:53:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQhfw3JSMz2yLH;
	Wed, 04 Mar 2026 16:53:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f31" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772603608;
	cv=pass; b=ce6wJdyWfzCVy4wuzfJauE3pfcIQ506/p1xBJl1T2Z25+dNaTAWx0KK4Sf61vhEHmLAGl94QsneDoNEeKul81qccVMU2T4F19Bm2b+bxv43annFoD4gLDCKNqbpyV+z4AjLHAU0lo5J3VIVMLKieUfO5C36Bud4PaYTMQKlyEtRQGw98vBWvyKmfO52PDVWH4IH2mJyr/TS8OC7oQxGX56TjDJGYSKZWSUpic7WTPVv2df6Mlf8Kzo5QVYzvvOS0MR8BUvYMwE9+l9l20+9wqYvf2oWpoII4QEqpoLkyGhdV0NCblyxwHz4NJZaBvCye1fwpsPV5b50iuPqNgPxBeQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772603608; c=relaxed/relaxed;
	bh=rKyIkXCqSPxisAP0oe04AM4H09RkMLHkS+dQMihvu+o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gQcMqyoG6zvEbX1U59injxkAPTUP/lHXQJhYxk8TZsA5zcz5+PTZLSZ3TvDSCOX7SLkjwhEh6Tbzxqn5FGGGiQvHKeW0sCjENdVuIkY0bKEBwVRvmEBPLEqcOs2BHFhbpfq5e7U88hDe74lcSFs+kTz7MyZvWHAFbePujFiPvHtLZbK7I6t/daoaDoa5WVeMhHKPBE7VfYXynUwGBmhdAUoMGAUKpJ3ezD7p2Fz7vthRKhJk9hMxkkLsKaFWW56Wk2xi98aEyInyKfVgHFuf7t9oQtVSMACJV/d2/hqCW8+Vb7yn69NvxmgYxStdAU8oAihlWIukw3Y+8X5Mb4vrBw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i5xRnvN9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i5xRnvN9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQhfv1rR5z2xjQ
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 16:53:26 +1100 (AEDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-899ffee2b55so3564546d6.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 21:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772603604; cv=none;
        d=google.com; s=arc-20240605;
        b=CvUJ6CWraVCgcm2KDRAK5t8nMEj0fZ8suvTp+KCAHldfZIx/YZTrvOpJQWCag9L+GK
         q6eUG5MyGOErszytuuwYJAHVisn6//+f6mFJcERrkqR+AYOe1Q5YVnwsXdbyoEBl34Dz
         RW6OVHc70TPLhdL3X4uM5uG1mymjFqpjK9iVwWea/wgewTM1UclmVtpCkM00f71NDVxq
         PBsfOawJ7wLTGrWKBjbMI/lu7G9+uzjI4Q0ZCnbaGNoHVORxE+7F01fiRTHolOhxpDi6
         HURdANpQmUN8gyU/AQ0QFNRMTUtovPvVF0WEk0MH34sk2w3Pusa7pQo+dKZZH5QQqpOj
         eJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rKyIkXCqSPxisAP0oe04AM4H09RkMLHkS+dQMihvu+o=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=A0KHRzAJGhulxGz70ubvorwtZ6dUy/tincPTAoGTWhtEkP8ox8KmzOJCthPn2kYPxN
         iwjCK38e9ka0MumZ37O/em8kt3Quvf3gR5SCkimCtw+9oHkn8/LJDmCfj1qB9keWFXqs
         AwNJz+pHk5iNm3kOFC0UGxlRn/YSW20VqYUi8RUbWiW+QnBVfCKq4YB9PxuwarSzwNjn
         L1lrVfoEbTaJ0yRL+Al+tmK2WA/EGGikYas+yyiQbxYRg9AEqDQUElmlfIIJ0jgsLOgL
         9pgsfe5jYn1ITItpJG+Z96DQSjelUjCsn8t+dK41r6jDoq3CVDSaQPY5JWl75BQalECI
         FEHQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772603604; x=1773208404; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rKyIkXCqSPxisAP0oe04AM4H09RkMLHkS+dQMihvu+o=;
        b=i5xRnvN9mFY1valbGL1Az8cJCbphpNONV00xoaT0Do2OZ3JNiQXvRCiITVA7TiN8cd
         hgiQtH/FZiDTd9sBKTnZT0z9fW3Gn/OQarg23zgBlZUvgCYAqWjTz+iD/sS09+BEQRek
         WbBbcYh++Fj4wxyLeZfAFu+7CnuTi6LndEjGhzGv/TIOG2RWXUVItCQrJalY8G3UbsnT
         IGlmXNoeRITO04kl8O3kiDC0UjsvhCSvup3d1ReWgcqNqe73Ure2LuF4yIsNLTAOrS/j
         kEc9RuBwvInfXOSDL/+k+Jctn6acgBVntSASCY/EHeO+Hu4vrucarl9/1CZwNelEC3gY
         Xv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772603604; x=1773208404;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKyIkXCqSPxisAP0oe04AM4H09RkMLHkS+dQMihvu+o=;
        b=qnlInR3udsQTosoGLpqpRk/Up69MSQUS1e4szPdAB1vrXMcM0dWn1KtUBrgKHYpKXK
         Ww10gi51+2gDZzRafhxCCxD4IQBwUd+Fd2eYikQMmbPsKYqJ0hPaVCHPCmmGxqzc1+sV
         zaiYrRpPlklDbgZ6XewIYtU5rFZBPdjUbIApyko1Mtwp1fUviB9dgwiXIUGI33uJt7Kv
         I7J0xpcSUW+kJL6uMw8SfEkgt1XT4E/xTRzoxY8gv0UiDJDicEu6dvEByDLdzgRNMVkq
         BdX7U1xIYf+LJ4OUutOYcKsaCO4JRPVX9Uhw4QDanMehTMj/P8WqR0/bUS9p4YyOVIHd
         88vw==
X-Gm-Message-State: AOJu0YwnsCRruMnTRi9Iem6igf1C7a8bH8Ts9GUjbhINXzcHwLEgM7B9
	Xaw9WUlmPlXFA5RYO8R0XzSTRdL0iEcMvaTMFZAEXk/8I90W61PguCpcIvkuv/hMEVP5MX6cTRR
	TK1dRxpg7kg+jM88kKAFJxpoJPbs0sJwX8q84
X-Gm-Gg: ATEYQzz/3qa95pqRNC3jokKA8mUIMDk9Hc+ElkUiNVELwMgDsP1wmHkkPRWic+plfFn
	62uPSKgDR0d5BJlPeXg8PrmXmcmSfEreIUc7TRwCszO1EZT0+R+VYCp5NxCzfzmIRNbH87LdwNl
	XaeIjWmG8rni6bNrMQyVNdB5u6jT9jt5YxpmvtyA6Oh/At/x4AFK38UTOW3UpNscw2NTIcfZTO9
	PBrmC8UPq5+5UtHZhS0bNoQzHGjhQUmThAaixkjw9Ga+GNi2vdrMRp6AKMzsr0ZBgD9ZAfLyqD5
	bDYBIGp+sTuRbf/+aDuDDCRSID1DzWoKLZLyQnsjMGPbKKt0lalNzr1d/iNhs/lHm7kq
X-Received: by 2002:a0c:f10b:0:b0:899:fab1:3ee4 with SMTP id
 6a1803df08f44-89a19cf9e88mr5780096d6.5.1772603603512; Tue, 03 Mar 2026
 21:53:23 -0800 (PST)
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
From: Utkal Singh <singhutkal015@gmail.com>
Date: Wed, 4 Mar 2026 11:23:12 +0530
X-Gm-Features: AaiRm51OZXvpESD2lyvpwdLa5kSsBlIMzvuPTnryZyvYsTpAG91K4QH3Dkj39qY
Message-ID: <CAGSu4WPCYtq-+hVc-tg_A4u3a3zxnizx7ui7QSO0R8V1DirJSg@mail.gmail.com>
Subject: [GSoC 2026] Introduction - Utkal Singh
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="0000000000001d70fa064c2c70a1"
X-Spam-Status: No, score=1.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 84E191FAFCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	INTRODUCTION(2.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2489-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.758];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

--0000000000001d70fa064c2c70a1
Content-Type: text/plain; charset="UTF-8"

Hello EROFS community,

My name is Utkal Singh, a CS student from India
interested in GSoC 2026 with the EROFS filesystem project.

I have completed the following setup:
- Subscribed to this mailing list
- Successfully built erofs-utils on Ubuntu (WSL2)
- Explored the codebase and found TODO/FIXME items
- Forked the repository: github.com/Utkal059/erofs-utils

I have read the roadmap at erofs.docs.kernel.org
and I am particularly interested in contributing
to erofs-utils improvements.

Could you please guide me on the best area to
start contributing for GSoC 2026?

Thank you,
Utkal Singh
singhutkal015@gmail.com

--0000000000001d70fa064c2c70a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello EROFS community,<br><br>My name is Utkal Singh, a CS=
 student from India<br>interested in GSoC 2026 with the EROFS filesystem pr=
oject.<br><br>I have completed the following setup:<br>- Subscribed to this=
 mailing list<br>- Successfully built erofs-utils on Ubuntu (WSL2)<br>- Exp=
lored the codebase and found TODO/FIXME items<br>- Forked the repository: <=
a href=3D"http://github.com/Utkal059/erofs-utils">github.com/Utkal059/erofs=
-utils</a><br><br>I have read the roadmap at <a href=3D"http://erofs.docs.k=
ernel.org">erofs.docs.kernel.org</a><br>and I am particularly interested in=
 contributing<br>to erofs-utils improvements.<br><br>Could you please guide=
 me on the best area to<br>start contributing for GSoC 2026?<br><br>Thank y=
ou,<br>Utkal Singh<br><a href=3D"mailto:singhutkal015@gmail.com">singhutkal=
015@gmail.com</a></div>

--0000000000001d70fa064c2c70a1--

