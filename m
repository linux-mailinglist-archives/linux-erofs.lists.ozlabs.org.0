Return-Path: <linux-erofs+bounces-2677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN1mCN+NsmkQNgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 10:56:47 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E526FECE
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Mar 2026 10:56:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWjgs1k9nz3cFm;
	Thu, 12 Mar 2026 20:56:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773309401;
	cv=pass; b=DrvkqgWrc9wgrmVOSGcB4jeihD5r0ePwH9FYb2NpD3xzNbO5cmqqnNwGtcShNgM6sMJgHZRevByHclnsfxxnPc80bk267Y4bt083leyO0kiOU8LeqDjZR1ZJP1GRs/ilJ3TVHKc0g3ATrhjW9hQYIC/H3eBfgoyz/LtH3zUAUurw8jGWpvo55CWFCPszfcs2jiszAdbrrE5X2myqh1g68WZZxbW5h1nRRbLsDYPmNsGhxASiBvXlOK9I6QHc/2CNkbbFbrJx4GvsfwzHEvHTOG/fTeBRsJmVf9yvg/u/j0JVB7efsylJufuhN1eG4Yt35W//5hQHCU1GSZR105g6+w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773309401; c=relaxed/relaxed;
	bh=vdPITjDTskCNlgF+ztZaiPF3gjBglhmNVlCvgd1gvYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gx6zmmNx4ODva+vLZ98tIwS/s+NeoXZd3W32x2au32FOUuShFlYfHVWBI8S15rcOUluWQ8ZZhMxAoVzIHcpNX7bUK3sGJJ3r6UOK49QE7Q756KaQos8SW1B1sl8IpNPhjR4Oa8N+0ppoW0+/jnWXkZRMp1Euiv9MRZ9z06RAegVDxAvdgf+eJqhtoSUyoEUzw55GYN3pvGjJkbIRiwbGWGQRiMF2YeWrlPZ1WBVeoauQFRDQHDstg4foeEJeH7PHGCjtkZjz+P0WQFkD4w8X0oS/RF3BaPuuw+f+53p6tA39lClcutU75ORZbGJj+8xjzYwiKbmCabV514sC1jBCBQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z1+CpEYE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z1+CpEYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com [IPv6:2607:f8b0:4864:20::b12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWjgq4brmz3cFN
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Mar 2026 20:56:38 +1100 (AEDT)
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so826494d50.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 12 Mar 2026 02:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773309391; cv=none;
        d=google.com; s=arc-20240605;
        b=lKH2ezBGebV6Lwy8TJ8WkEhny5mJmQqpDFqZAAh9ipN115iNgBasgrFE7w3yYJZiz3
         GgKmf6xO8tBfZw8N5gEt/55EHjOhY1zdTIVWDRzMXaSd+mH8ezhV1olvtZ94AeRgAI+x
         R0hUFoAa1e2NfDTH5pMil0g/4gEfyn8zT0BKOeSPI1BEB6glyKvm3Sc6xH2Fqi23Kr2D
         oLnJ5ZIRc664qQVDIzZAqv9tnbyMh7oA4r2mhwNyvwf7RE7NHQWqSeISMT4YygNMrdEX
         ueiAqGsQBcNIiluV4zyCrWC4Qok+JOL1qvxCEHVzIvGkG2YEwBM19Ah3CcGBeTEu0PRK
         SpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vdPITjDTskCNlgF+ztZaiPF3gjBglhmNVlCvgd1gvYs=;
        fh=iBiUabextVJS/qLr/dyENh1QjPfvHYpbroAtJrp81E0=;
        b=jEXTApBdLgVMppIPKzua1VmnR9m5o4++UND3BXw4inFDOlXDfz7Zk8my4af60KAuJW
         eCty3I1fu6A0QD+nfZAByItZEOUOn/5nUmAzCKxvnYTF9z9pF3XB8xeOqGuMm2JM2Foy
         Psg0oXw9L4TvHKQQ1sV7cBYVUgYbo7zx1y2uIqOkg2V3xdS4NCZgThz2XAJ+8DzlsMdQ
         lE8VZNLbQZ6SprRQ89faWAjbfwXZik9tt5JWGVm0o/nCxunN81uFT7n0HLvPSZXJm4vO
         WTxlv+rRX2uV+s7zn6edeK6F9SsWFrt4x8Pt1qPCYD/i7WKqDnHyB9lxsAltopLdvAE2
         SV6Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773309391; x=1773914191; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vdPITjDTskCNlgF+ztZaiPF3gjBglhmNVlCvgd1gvYs=;
        b=Z1+CpEYEdSF9nuKTVUJ3uEFZSJIWWI1RJpxAgPcm8dDc5KCubETUP21EIk/naEMGrS
         327/tuf8l3NF4IVBmVJmcMPMIsYVKhP9ecqtcY3CrpRIXrcbjzD5EkyeuGGmKRoKBAma
         HbfhIU/3aFzR1RNTBhd3TNodbTMWQ2D3K3Y3ITT26XEQ2L2Oy4wP6rSlVA77kNSi1cIg
         3opCuKKZWf8nRTu1oVJ7Gl2TDqgkvnfuLKIZZJ4H7uhB1IeTTxkVDBWMX4qloozszXpZ
         Z4ORzcMW8TFc1CLEGfP8wOzUN18vXd0r54/TYIK/NHl63tB+CsAUW2KXW02iyc7rRfM1
         c59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309391; x=1773914191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdPITjDTskCNlgF+ztZaiPF3gjBglhmNVlCvgd1gvYs=;
        b=rKnpeBQ2DwA0GUlV7DjfsaDZkmEUjodQfN7bkzO+S+D354cbJitXF+iZw8rHGcEL2k
         SHc+PuGTA6hhJB7JR9bDEu8DpNZXfNdcOid0VrwEz75y9a+UAC0tVPWSRaeSmbHRupOo
         EhIV3hsteL+7M3dZytv8wLz9KnERGoHtw/WUsGOmf11ivoSyEb8LTuJ10tbjrbkKcfm7
         daS1tGnuZWhO5+E2Lt6rS8YN6r2U0bC3vdANx8WH9Ta+Rvm8tEG0hCkGiqjJaXehAmKV
         0PydsVhkl5w79nJaRIY1io2b/ZMVGsiWyqJ1Mi9slKKKn/iVQ+bcHpom3jDl8TtYUReE
         xvOQ==
X-Gm-Message-State: AOJu0YzhrhVwsj5UAM1ZYTOItMXFa21qa5M5+UvhNqK8sY6f3dPZ1Bjv
	W0IEsmoPo6CODDawfinj9E/g0H+IHsKxcjNCzTkJSy/JAhghDfhqeyRHgaWojWrfwLth7EDvcpt
	1VfsHWSKY0VYLX18bGwt2ds+kZ+YD5+k=
X-Gm-Gg: ATEYQzxoYYzI4uc8CfHatOGSWQLbMkhc7eZnJtmUI3ZM0ox0tDT/mKaWf13kQxqs4Gz
	iAf9htRASE0GRZ893bZand6Ub6HeZgTh6RpMhA1kEDq5MYlYIYOdJ9YFk7yw0eFCV0Ah1vObUf3
	OMnoEDCTszKYxS2C6pAIZvtjjkYFgSEIa9T5frk8AOxPPVWp2rpRThHXR+sHoFaEDIeNl0HPxzy
	HtVgdUr/8vAIfv6J4+LtdBfQ3iqVdw+EKeqrHBozCWlJY/5WmpSClZeQ3BAB2X1YKXkJEPxNY3+
	Qy5KsZU=
X-Received: by 2002:a53:a290:0:b0:64a:d311:2cee with SMTP id
 956f58d0204a3-64d65854930mr4037471d50.89.1773309391067; Thu, 12 Mar 2026
 02:56:31 -0700 (PDT)
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
References: <20260307062810.19862-1-nithurshen.dev@gmail.com> <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com>
In-Reply-To: <b9387ac5-e717-4e9c-910f-5b218d177e64@huawei.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Thu, 12 Mar 2026 15:26:19 +0530
X-Gm-Features: AaiRm51tckf_oAwCFnV_P02wr3heckDElwS0w6tcTAWE7qh1ayakwOtcOrb5j5g
Message-ID: <CANRYsKgoA9pMsDnBRnLgpY7ydYcuq8FxEhs+NCw9_p2ABjsMnA@mail.gmail.com>
Subject: Re: [PATCH] mkfs: support block map for blob devices
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, 
	hsiangkao@linux.alibaba.com
Content-Type: multipart/alternative; boundary="00000000000054dff0064cd0c469"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2677-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.992];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 452E526FECE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000054dff0064cd0c469
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yifan Zhao,

On Mon, Mar 9, 2026 at 5:08=E2=80=AFPM zhaoyifan (H) <zhaoyifan28@huawei.co=
m> wrote:
> not reset m_deviceid. Could you help also fix this? If you are
> interested please also add related
>
> testcases in erofs/erofsnightly repo.

I have opened PR #7 in erofs/erofsnightly repo.
https://github.com/erofs/erofsnightly/pull/7

Thanks and regards,
Nithurshen

--00000000000054dff0064cd0c469
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Yifan Zhao,<br><br>On Mon, Mar 9, 2026 at 5:08=E2=80=AF=
PM zhaoyifan (H) &lt;<a href=3D"mailto:zhaoyifan28@huawei.com">zhaoyifan28@=
huawei.com</a>&gt; wrote:<br>&gt; not reset m_deviceid. Could you help also=
 fix this? If you are<br>&gt; interested please also add related<br>&gt;<br=
>&gt; testcases in erofs/erofsnightly repo.<br><br>I have opened PR #7 in e=
rofs/erofsnightly repo.<br><a href=3D"https://github.com/erofs/erofsnightly=
/pull/7">https://github.com/erofs/erofsnightly/pull/7</a><br><br>Thanks and=
 regards,<br>Nithurshen</div>

--00000000000054dff0064cd0c469--

