Return-Path: <linux-erofs+bounces-2543-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCNBADTFrmn2IgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2543-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:03:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BD2395D4
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:03:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxz30085z309P;
	Tue, 10 Mar 2026 00:03:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773061422;
	cv=pass; b=obSKpdviI/Dy3Y9hElezs803UuwpQxqqdbkT+ZD1HkCaqMF6A4ylzPWLQayysxd4gUJia4mJdRfOL7XKa9VBvLTjEsEbuJeVOFXq0LJ+6adSruK/CSnfl08NH9VtOt0V9oQdRj8Zv2BwfMFXb8u00NIgIvnqp4+cB94iEawF7zoWNGN4bZn9zdP2YYy/hreAbqIUIYmWyf/EkaO3WvSYJ4XqmpMaLPsarm6Uf+EjAI87uUto0Wr0ApOiH+0yNWQ79wVjRFaO5i9DXS8kQB0odiLJstbwsvL4V2rpNj9GvIab21jXZs6SytyNkLTmZjVH2sTm9Y4JJubLPKGG0zkUYg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773061422; c=relaxed/relaxed;
	bh=MMVCFDm6/THH9cmRFTEE6EMv2ieaErKAGcMAeuBKAx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D81upNA68HCyj5xLw9nw63t1ilO8THnoeMutvw3Q7nxZoUgHycBylC+13du/sXHrICo928ttPbafSalHX2rBH8HMTz5TETDPT4Ux6gHFnjlS1WldC6CTaIJ67tQQX6BGpjRAlL95YiJ7Tlu81WhSjz9fdqKjXlFZHKqahWBDLR9rMHkJF15eep4owOvcmFEii8SoanRASHRdyPphXYwHfpha4AF5Un154+vguJ900PKYA1X0FSLCZxbOA002qsIYWBa93lbIWoHGZKc24oLu3eQccMK/K0/Tv0Bf9sjrE0oNjfjkD8pj5hGw29BcBL2xHfwB9BnDAApHhQ+g5j4Uow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bngsDbfI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bngsDbfI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxz21JC0z2ySb
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 00:03:42 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-64ca09f2056so8481581d50.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 06:03:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773061420; cv=none;
        d=google.com; s=arc-20240605;
        b=eoH2puFBef+qfNmbu0mxjrXfRLYSpVfQ8Y6bxCw3cjJEtVJjapLQeDJEM5h00Ftx57
         fWM7lVs2o9XTNf49t1PL9RaHS9QFyWBLhJS3uzFFvgHFgmQ4fK+7KDBTSfUow+BwlemE
         7yWlJPwRb4Hcgct/Ppq5kxIWcHfXRCCwqP5vrPcubGqL9Qu70zWjrylEH4BDlOo+CMTJ
         NMXkym5TTYOU58GvOuQkBNAx1Y8zbl2DNWrBNmtn8FSpJjzT4fblMwpKIbkcDfpVt1cD
         L7Xqe6engRAG/WHKksNqFUYX7mli+6qI+rkfaeSn8GSS2GHEkQE0GIw3V4QVUz4YHW2C
         meUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MMVCFDm6/THH9cmRFTEE6EMv2ieaErKAGcMAeuBKAx4=;
        fh=C+4eN9cqdSuSNf2G65+O3d+nST7n/0pcAvcqzzmG3Dw=;
        b=YphVhFBNduMk928R4YrH9NDRTxRL7HaxtQ8U6YAmHsN/WbTPxNLzW9wBPd+e6xKfYn
         hlZznwXJROAml0zxRqvq3DGDRvWOtswl0bU5jT+TmFU2mVlLhhtXv2eZQn6i38XrNFBa
         Obh8VLZbnKnas0xT4WgamedIqyvWYoNEmvmd7QZpdT1evqb0VurCpuoZYGx0AL5I2apt
         /G3DdJT06hUr1EIXSB60zrN9JMjP6CnzdeYVpWLVY+M+j84SMZw0wKpCVYV3InK8wzP+
         pcSyTob6Twxush5WaAwDtH6XMph7WFd1649IxXkTozXAXfftP8C1osAaI+yzonMFhTlh
         V3zQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773061420; x=1773666220; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMVCFDm6/THH9cmRFTEE6EMv2ieaErKAGcMAeuBKAx4=;
        b=bngsDbfI/QzDckAgkoM0ktPAPgJ1APfHTnqU65oRVqugAKgAxyuh0XVgdMGH8L5UgT
         pu42FnVlqD19cR5sSUwhBbuvPyUSDO9g4pBypl1TmCJepsfo5AamhSYGWvpNoRXZClot
         bcJmnKU8Uev2Y0wtpqSBvqI7jnFqrYpyRdD+6CaMDsp62PwhH/viLJFAJKxxovaKJoeT
         jVvUxmqZDzMPh0HWzHOh662kzwIA1wSDePa0ggbuLuu0FBiKBgnbtKWlRm223S/v3dxI
         MK21TPPdwccnx1x8ZQY5rawfWMPEmtThJmZGbwoxBae/0gnkAM6k8UPhedWhYJqQZkAQ
         KOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773061420; x=1773666220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMVCFDm6/THH9cmRFTEE6EMv2ieaErKAGcMAeuBKAx4=;
        b=fmAjlTzEGRH+yjhdQmlaTTcq4f8LcCDk4oL+eXiG8lPnc35kmgOWcUfh/Al+NN75cn
         E1i1VZESKuj3HPei3R91z+baC7l0OB6C0rfLrN17zW2u/0hDypSBWBEBn2Xs6qcEfJXG
         7vIh6eY2hgCd3JP+x53/cDHtB9YQeJwCgokvbIIPcykGR6GWhS6f0z+Ubsr5fo34KHyz
         u8kjS7VLRyRO8/Ytqp1Ojn38LZhk7awlZL/6YDxb2TSn1XwChoTD+Zmg39lrU+iQLhcz
         /Cr0MlzsKCWl5VEL6CnBwEUF62t42zWImAnmztXhuocnsLVzy8m8qG1Uo3XR8D9Se4r8
         isNw==
X-Forwarded-Encrypted: i=1; AJvYcCVRXGWU8fMwmvv/tPvJU+Alh/WfiwU5ohU+2+hwiHq9VX8nCE7fZeWDzoOWcpz401/Wlux5uqFGMlqwtQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOqW71n4nTuusLRTG6OWcSCsZdo7o/tEDuMd58VTrNtqqR214H
	zl8rBU95UYri7hfuo7HhK1QXkRdBdcoAqG/7HY+jYX/85pZsrGPHINR90E/AkrZ2QoHHhZaCli4
	8cWGpAAyTOxGei+GeNHP7GcRqglaoj7s=
X-Gm-Gg: ATEYQzxMOHSE8jyzARQKmfuPQf/AulvXrpZAGTPDEJyH+nY03v6U2w7nER2dE8kQOA1
	IP10l4npWfVOwG+SqqyPhqj9Opgb4oINoKcqZ/GJhZQYbtStUrdnOCFFbzXJVbhHpgjiH1xEWvr
	Su32jbHzes9emiCmrzFns1PYjqYDwYtZHnHPVwUWRkF6NqAzIo/wY01YWRGEy9bThJ1GLCl/PLZ
	1UsYJgj1/LyeHY7HQ4rOj9cfkBNFgJb6zdHN9Ka7HNrFxT5AYlRe/oG0iPHuJsqjdqqnOuGGwjs
	hM0CaIEigl+tw/xjfA==
X-Received: by 2002:a05:690e:68b:b0:64c:ae9e:1c43 with SMTP id
 956f58d0204a3-64d143bc02emr7802489d50.89.1773061419274; Mon, 09 Mar 2026
 06:03:39 -0700 (PDT)
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
References: <20260308034749.22233-1-nithurshen.dev@gmail.com> <200e31f4-734b-460e-af18-e78952478598@huawei.com>
In-Reply-To: <200e31f4-734b-460e-af18-e78952478598@huawei.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Mon, 9 Mar 2026 18:33:28 +0530
X-Gm-Features: AaiRm52VV7_DIROHbzhtX-dgW8l8xxc1YrxesVL_qR42gm4JOMxmjKYkegvwXrQ
Message-ID: <CANRYsKi1Ctc+opWqRo2BTGeb-J-mDa88Ph2ezFV1ZJobKNETBQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: add --exclude-from option
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org, 
	Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 376BD2395D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2543-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:nithurshen.dev@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi Yifan Zhao,

> Hi Nithurshen,
>
> 72-char limit again.

Yes, I will double check the char limit from here on out.

> Your code seems could not handle regex, as you call
> `erofs_parse_exclude_path(line, false)`.
>

I have taken care of this in the v2 patch.

Thanks and regards
Nithurshen

