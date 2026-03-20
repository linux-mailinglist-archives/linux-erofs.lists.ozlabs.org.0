Return-Path: <linux-erofs+bounces-2891-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB0LI46EvWnQ+gIAu9opvQ
	(envelope-from <linux-erofs+bounces-2891-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:31:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB42DEAD0
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 18:31:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcqPR0hYHz2ybQ;
	Sat, 21 Mar 2026 04:31:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b130" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774027915;
	cv=pass; b=d2kFxI0J+NtVpVAla2L7OEzu//31hIT2nRlCsv47bpy3qfW3hpLSuhFxfUo2S8hbz0vBecpoAvFPAE7/0PKzzKhBNnSmVLovPZ/Ly5CvflWAIhTzhgCy8j2WOGfVcKasO54OGtxlHnm+vNa4JyCqflshi1w/W70tDsQfOTl6uyrQY9rpITC10+OQ7CEidr4giwj+fYldyb3DlRNgMOdhYWcg77l6dk75RF5PeHGMuUL1HBUithnC+nJTqFIlNPj9eTGhU0d8Y67MWGKZ/IcFAsYBluxwoflujPxYqt7F8at1d/WN+lE/uIjQcHDkU+NuBm7kQk6DgrPE7JGFPqgrmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774027915; c=relaxed/relaxed;
	bh=PuIZpNg/zyBoYABbTKMWA2vznU+EYMYO+nFneD7E3yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5IVO64Ip3NlOKEon5hKiHMxso4T+cwmrCJvmjMuwltytSIgM6Z4xAmu3uuQxy3C1uioPqndFTf5gU580VGZfQQ9VsKwAZVdouMBq6H4nxLtCEmbUi85NTZy5Tm05o2D84yfELHavwn03HDGQzsMumPcwMxYC1WQa9ANckSKQ3EZLc//zjo6XWPBkz+MYl5Ww7QWjIarTBpXaVQeq2yJwuAdjoO5qvZ+PnMd+BvkNNp2EhaHLVQu9YJQEBc0HZsBAMWI8b0C4TmjzFLRrSWcvaB9NTil4CHWsFvnhsrb5QsoejzytKlOWRehbUvO5p0qpSiL8wgNo7X7oLvGRTWNtA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gl0UfLeu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gl0UfLeu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com [IPv6:2607:f8b0:4864:20::b130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcqPP5tB0z2yY1
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 04:31:52 +1100 (AEDT)
Received: by mail-yx1-xb130.google.com with SMTP id 956f58d0204a3-64c9a398bc7so1989378d50.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 10:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774027910; cv=none;
        d=google.com; s=arc-20240605;
        b=XLHcu6M9W40Co3ADEIBgMNE530Zh6iJkaxeaz3p+aIej5X9T0ron5VW1Gi/04y/W5Y
         VcYtj0snDrFlVvIUfGr0foe1f98ryopgl08YFqN3v2KEYh7a/2aBuvRbVy+MB3ri8BUk
         tkf6MVPTZr11tUAjocW3IV8nqYhGrPoi/80vr9xH+DMxFS9yT86Lsn1bZBLyHUEyZt3h
         HpufHBYb48Hg6QaMBE1+051Ph5nGnpFSNVXuvDh5k4Ca9pBqMNla5TFDWrZZZsCC5Sb9
         DWjMhycd1+zJ6aD5S7drDnq6pQb6SedDxtVLjEI9JGOeF3rBH9QWhvEl+HpEKNYn9iZJ
         /dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PuIZpNg/zyBoYABbTKMWA2vznU+EYMYO+nFneD7E3yY=;
        fh=rFIjmt53n1zfWXgPux8IqwKbHHpRVZET4FCyNME6lW8=;
        b=hFI0LdzuWsymQHyu6NfDHSHr5y+A1h+i4bwPp5aKwTCjGAacYaaDgxOAcPMx3gLaVD
         kcPkgr3aZGKQvEuumZXi9P4M7nP0VQFEk8rsVQSWHaN40QWfC1+kOZul+scBsDu5Ylgp
         yI9x0DC9LkAGsVMufjO/XSDhqiUYBpfM7vpP855S2ED6dwkRRQUZquE5AwUwZtLKp3LU
         qcF4MPxvSotZHup1ES0RCZewdo9D/0NdTEfipAcD+sK4e+DC6dcey9sg1Dvh81EPZowL
         OcF/Bzz7QTceK13S0RBMjWLGPtgtBtbfYENt0ZCjyJ9G2lbqMSN631r4//usRCj+fKZq
         hABA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027910; x=1774632710; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuIZpNg/zyBoYABbTKMWA2vznU+EYMYO+nFneD7E3yY=;
        b=gl0UfLeu/uRhhUd5geO7puEVLJnO54g9zRNg3yc6kYLKHIUYWSHh1fMDLMt4E+gPPI
         afiKPV2KpVfq9MWbmFkuI1Dk5TXnZI1HNKR5ZyPUweXL82TrsEig2nG6slj1vaSCBHjm
         UTvyKbhnTIvGUzPFN5q7KOhbaUS3RybOw3c1cDqNfPTp4ZB8x0FjqVKk44iEk8Rhd8rJ
         79qPPIN1gg38TEwQhkg7AmwpCAJZjNafxZgqUq3QgXetfpfG6+uZw15ROnZrmg5dFJne
         owmasQZ+WKKwob4HTf3aLwSar3o1YayKL6UC4c6bXDhVGVued2l/a0kswMqc/L5BZzAv
         ztnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027910; x=1774632710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuIZpNg/zyBoYABbTKMWA2vznU+EYMYO+nFneD7E3yY=;
        b=hP4lv/OfEo6AO2qj9RjrXf8G05PIg1liwc9Qxn6uqsaAW0BSdW5xlYHUTgjcl2EYh/
         UolFHVXGNzSoyAU+sIcFNLvPqowazW+LkXCB29qYJwH4aFVzkUy/H3OcfDK14TiXBIZa
         HH2CKUF3Z/BovbtC/VvO7kxd0PKYCZbhu/3ndcoWc14ufK1xTeA2R3ec/fsLsMhhWIhO
         MSMadhZEyD0peQkOFYDNnj1s3Rsc7KiPCKc/kB5LcFFS5Cd1PqJnj/J/Gd+GwJjRpKI3
         z2Qh/LB5ZQamkaTgADt+UzgeU9He2dbGZV2UySdu25Nws5e+u40xFaYqtTiqB2WRQW1k
         sKDA==
X-Gm-Message-State: AOJu0YzNaXF6sTBP6V+D695vXJccLKnG8EGcV9ur0Rx0XlhFlTrX+KJW
	vBLpqnVMW/vZJoWVJg4b2k80Fsin5a0YeoEj2vqerkRWt7nW2vPSkF3FakgAJ28TVtLT3nN9oQq
	4LQnjDoDwtf6k+DDYHrxlb8bgkfIHeEU=
X-Gm-Gg: ATEYQzxz6QCRRwlTd5Abj+VCo2XJ4YVSZX6SspD66lY+0FG+8k7QpJmiy77Q4rQbB5m
	6d9KYxMBPOeWyT8wTHr4aq2dl9yybVXSOy5UMEW+1UuJPicdRO/9ypNq8kV1fsrMCe6bV5z5N4X
	xrn+rjdMXcx3f7paJ2NvvssmP+7eD9CPTZ8vzmU02RmWhxexwHL7xBgrqOy0P4xldsels4WO9AE
	bkQzwvmE3eE+U8rWPYRQchtu6GkhPTitufhOsWGHEwLAfJzRXOSRmRiBopeDQk9sCWzOwc70NYJ
	jeR4muI=
X-Received: by 2002:a05:690e:e83:b0:64e:a1d0:1142 with SMTP id
 956f58d0204a3-64eaa704469mr4170813d50.30.1774027909832; Fri, 20 Mar 2026
 10:31:49 -0700 (PDT)
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
References: <20260320165200.1862-1-newajay.11r@gmail.com> <20260320170430.43337-1-nithurshen.dev@gmail.com>
 <CAMhhD9gyEkNO6ycBGqADyTCAhEHjbBPU-ZFB-LAZXQtZH+d_cQ@mail.gmail.com>
In-Reply-To: <CAMhhD9gyEkNO6ycBGqADyTCAhEHjbBPU-ZFB-LAZXQtZH+d_cQ@mail.gmail.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Fri, 20 Mar 2026 23:01:39 +0530
X-Gm-Features: AaiRm53ET4_3P2wmZ6trk1dXy1jy6WU1Mcw8LMOMtaUEhzCfvvZyyd-nVjQWTcw
Message-ID: <CANRYsKiXFbvCfNRK5JVn=2hFcvxgWL-K28uRAh+8ibJz9rvg-A@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Ajay Rajera <newajay.11r@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2891-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: ABAB42DEAD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:50=E2=80=AFPM Ajay Rajera <newajay.11r@gmail.com=
> wrote:
>
> Yeah, I know that both changes are not related but the fixes are small
> so I did it in just one patch.

It is not about the size of the patch. Since, there are technically two
changes that we have to test, it is a hard requirement for each patch
to be atomic.
Only then, we can verify each change individually, and give a
review.

Thanks
Nithurshen

