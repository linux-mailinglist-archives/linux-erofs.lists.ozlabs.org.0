Return-Path: <linux-erofs+bounces-3864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sUtOE/RkTmp4LwIAu9opvQ
	(envelope-from <linux-erofs+bounces-3864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 16:55:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89B727A5C
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 16:55:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=elIpo4Rw;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3864-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3864-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwLkS0pbKz2xpn;
	Thu, 09 Jul 2026 00:55:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783522544;
	cv=pass; b=ZgA/MTl7qXA69REV0a4Un4JJDfV6BSdkyGUhaQTD1uU3apsy7uDzEMH3WGz8GFO0QimxufSSlEtRsencfg403gZ1ytSMSvozSIie9dYtPAMBgVLFuVcYfYtor0tprmWBuiWoeLCyDFOcWiNY85EOL2upAOtSOwfuuHghRmkcIB9O6930862f4ZxSc5i1v7iooLIPUO9zYMREgZoQOWbiG67WE+mdUfd4sVgIxL9NvyPbhnSY18dwmaS6wSXdi3xP4lmu4l71AqXsb1z2Qu0D48DWj7RXUHFYc3JNTCcrOD5Z1+70XohwgRZ7GAPJzbUt8mq8Mg1cTZUMf41AkLRaMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783522544; c=relaxed/relaxed;
	bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxhOu+k4GlcOtFLV+KHnD90IWwAA3Ejd/Lm74lnAYJPsmTJwJGdqoKt0zv8b9NZEkH9EZ1soZTbnGFjfChOSBk8pGag1cExXykvcjVSRQCMxQ7uzGGVdLSKj17oq3i1l4XweqrJ3xIqAk9pfbiSETPtrjBmMvyDv9wzN1qEFoT6qsb1A0vS3i0RUxKqwQeWwFXj7hUheACRUOPqZWaAhz23dmy96D4EncyqaW4Zo2R5TLAe/vJCoce2PgrmL+iVixXhUxQ8zGp2frdar6kbkkBZmUxxx02FsUc9JRgYa7a/hZOZq/VUlgY9OjOTvhDbwCQamY2uC9F6aPj9FJ/ya8g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amacapital.net; dkim=pass (2048-bit key; unprotected) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=elIpo4Rw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=luto@amacapital.net; receiver=lists.ozlabs.org) smtp.mailfrom=amacapital.net
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwLkQ1Dbsz2xll
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 00:55:41 +1000 (AEST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5aebfa21c62so958430e87.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 07:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522537; cv=none;
        d=google.com; s=arc-20260327;
        b=sBd+4WrBXLLXX2aOnK+Qi521WBn1oLB6giG30wJTcrWoblp3xya72MVsUeEgyB6q3m
         9/kYgXWWTacLbmgQD3IR2a7TFsBzL+00H3GWMxacDEcKVeDmLt1FMA4h3TGhXdrOo+Uw
         2uT9o2e7w9kghqb1GEzszT+QViauvKl5RQXsCVGc2ypYInqy34AEyZqwaTKMzFfnjPU1
         9ryyTAXJPRLRZb89V5CQr9/ym9dU4oni4poemQgLbpnkW7AIMaRI56istZP9q84gsl4d
         Ei7A+NlI/4+4sG+uaQvAg7U6xK2sZ9PIyHN1dHhtqGw3y7N83Ifsd8Gq5V+3mkJSMOt0
         xRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        fh=E6/a/u5MwtqOnW8Z8T2+60WLZGeay8SoRt7JH3B7YE8=;
        b=TuaQ2V3LYuP1Hcg4+57/kieUew1lGm/YCaoitdJ7UGPgKYpG4cywfVOgajsgB7NsiO
         Htgd7c9nWCowT1kOFEc5kTHPW1e6oUVg+K4T4SD48YObyWyObIvVDEfrmOyb15E2itu9
         mNSNGW6eNCMMbR7Tn3TR/mxb6rjEx89PypxNzKnALzZe5+k75hUGn0oXmVi1qK1utum7
         on9pW2SEScboVu7cv66si6N06nbTlGl3evU2w607w0oGnwd7MOy11QMX9ZN5naVgYjtu
         k0Sc7q4sfrV5lDHdzIzZ5KylbWTsKkG3agjlY3cuiBdx4c66XoTo/PPEZZyFrehQRFIE
         eFng==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1783522537; x=1784127337; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=elIpo4Rw+gX6Q/D+QIRcA7tYY56r1mgXMQHCz7qGk5CKRL62CVE7gy+sdPKM6TDIZE
         L+V36v49hywXQlrjlFFktIYTZioWYgoz2o1+tEcu6igvyI45O9P50Ulp8SQfjImBC01h
         5O5kF+gpLdfxjXlg/AxiD5VxSBcE734EGNbWnYu14WWvKhwPkZluKi5ZM4VCZYAePuh+
         M34jr9uhTAddZWuh9NIX1gmwxmvIYwuIEXuiqPibnL+fPqGMLcPFOkQ0Q/6+HO3kjzG6
         EJ+mNbWI962A0A5jAoy41/hVvO2ewR4+QDVx8VEx5WQMGdT6LTq6AjAjNJ5GUi4BLIwp
         3Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522537; x=1784127337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=bpe4dJ003u1JyRQRAOPSwXk9JYbzAPNyD+wo0fs2WK9bM6X3m+S0XbsErbw2YqDn/0
         RTybsp+qqKTTM2PpvdZqnNWRB8Rqf6RbZpZq+Y/grDM1F10Xqw9FQURbPMBiGqNwgXwV
         SH99hn42cCCOUZvfNzy+SrksvTvG9gD4mj7CgENJ76s/QsdUebuZD+o1iFNSrNreRkrM
         in2b7NX36/W//n6uk0dt8N+Jb9Mc0t+XjFnasbyYcCz3KnM1ieUZoRscgapuBGMjSjhl
         RWKn9D7bwayf3X9gsZrSna9649eAkmy2IB2CiWgxz+8qY6M5IVMEVa6JS2yrhT6yvXVt
         BYIw==
X-Gm-Message-State: AOJu0YzBGNtChxHbpvKFIAC9+4P6k0htJUrFlKyLYl03lBGECen3CURz
	P47tGRkzcNcvmxWA4/astvGNq6bO+qghDRjXPb+iw1hExST++ZvoVKKanp4PrFMsTngyZgWrlbr
	OBsR6+EYoI4KfDxYrNqirqB3Gt644oHh1Xbq53t09
X-Gm-Gg: AfdE7cliLZ4Lfc6wGz0E8a4o6m8Igdswg66Oiqbqa/IUsYy8ditKrKYdIJ1inZzPYR9
	y2KtoIVxetqJZ5Ax/AfDNZVdUf13FJDStNJNzgznK4HR2/g6VDhO0rnDGLc9ZCD02K5sRDZ/nWS
	y05jyMxL2FYD3ABblMyuCS5raZUcjmAnD/6XhJUBnggik/VwQ3drAH7tTKHQ8CA1GVBOvmw9KSC
	6Oy6Z+z/50kFg6yT73GcM4yaNaegsxPLnLw67OUiiEPq8U4k8Cz1McGO8eV8lS4DOKbkA==
X-Received: by 2002:a05:6512:8348:b0:5ae:b5d0:9da2 with SMTP id
 2adb3069b0e04-5b011462b7emr693309e87.38.1783522536822; Wed, 08 Jul 2026
 07:55:36 -0700 (PDT)
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
References: <20260708093446.3370200-1-gscrivan@redhat.com> <20260708093446.3370200-3-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-3-gscrivan@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 Jul 2026 07:55:25 -0700
X-Gm-Features: AUfX_mxOfC8JmvatfXCPy4TV9OGzLE6zGNnyTgpXNYag_FZ0rPhcjgOvQmXLouo
Message-ID: <CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file descriptor
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3864-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F89B727A5C

On Wed, Jul 8, 2026 at 2:36=E2=80=AFAM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
> backing image file for file-backed erofs mounts.

What=E2=80=99s the use case?

In any event, this seems to have potential security and API-oddity implicat=
ions.

1. That capable(CAP_SYS_ADMIN) seems critical =E2=80=94 otherwise a task th=
at
is admin in a userns can get an fd to a backing file *outside* its
container or to an otherwise inaccessible file.  It at least needs a
comment IMO.

2.  This series appears to fully round-trip the struct file. That
means that f_cred and mode are preserved. This seems strange and may
have all kinds of accidental effects. For mode in parallel, if the
program that mounts the backing store opened it for write, then this
API gives a writable fd, which seems like an odd choice for a
filesystem that literally has read only in the name.

The OVL variant has these issues to a lesser extent due to the fact
that it returns an O_PATH fd instead of an actual open file.

