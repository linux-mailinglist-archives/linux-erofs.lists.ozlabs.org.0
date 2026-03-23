Return-Path: <linux-erofs+bounces-2952-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOIErghwWmTQwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2952-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 12:19:20 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803E2F1154
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 12:19:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffW046qB7z2ySc;
	Mon, 23 Mar 2026 22:19:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774264756;
	cv=none; b=Jy8aojSjYQE5PnbThkz6LkxK/dlJRmC42R4UUGs796sxG5GlwYis/xQrhhhZX+LEbLPaDc3s7LeXm8V7z84kZ7PTKO/2KLYtf1ishHyGqKd8qm2GdMsnxR0eP7DReV79cMe/d1diqejrrK1ynWOJ3BF0uG0Zh5nsnXrhMOmQDWxRAWK9PGPmxwm+2W0CRjMQOBADqCGIXDSvwEwP1fZOB1jCEsGKaVbDvfn03K8djvI+mUU/jcvzd04vwRyyrb1XnMX05aSiXvmB1PySr5HZiy+ToJo2oAeaDCxM4KB7k21YHEmBkPtKxtuLKYMoIsccFkVIImrylBTwKf9ywj/kIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774264756; c=relaxed/relaxed;
	bh=1gmTaEoAmJ+H51pzw1QqEPleAoLI0tsf9MdESQRJ5wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHDZMEzD21+s8KTsaNMJTUjbd/STFzN2JXPY/HMfcpbsll/C0PRP0abIrCbw/ttsZXo009Mpx5n7zsZQwCHysUSsXOqwsetiThVhXIDyIOHdD7+jsgG3iBSBTecHjK2WoXS+zjjyM/v2OhG1A+9Z3DTqiKJZvv15oHl0SCclaKLLyWAkZCQIPDcDlIxH36PvN7f1dcfrTwsBkCuLwywJ4cAwby+KtyIebb0lGrnv/bNFfKsUFBBC+9cbf6mgaWNSMWvr9458n1vji76iwcOMjkrhXNx4mRw7uuicmgWYMuadT02VihW0Ozup/a+QAmXrFK8YfJ1DVturcOADYAhNDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bl2/xQiV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bl2/xQiV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffW031q9Jz2ySb
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 22:19:14 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-43b45bb7548so2918848f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774264750; x=1774869550; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gmTaEoAmJ+H51pzw1QqEPleAoLI0tsf9MdESQRJ5wQ=;
        b=bl2/xQiVjbxtJ1UN6Xk+rwa+onSqg0vtKDKTeemdqc/9/VEuhBBPqFYnro3A5nHOBL
         jA5wLV0AB/3yFvCDhiPGgbqYOaRHFdgs4QuyFfwPNRMw85BXynEcXsFTvR/C200wM2jH
         MjWpSkoViCkLkxKTD+dGDqJvGDqa99mNu6wncoP455kFe0UeuBrewS0/bkUQvdyIVpIO
         rbd81l9pXNg5YS1rk37rQEK2gjhu5f4IQ45MydFHmJOgJXpEPAGnPp25HgBJas2hgNXN
         AqiZaU2WZ3OcvSuxrg4xVbWZ/mzigojGPfmNdq+EoLYcaqFlX71EdoclnwM3G4cc580M
         D4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264750; x=1774869550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1gmTaEoAmJ+H51pzw1QqEPleAoLI0tsf9MdESQRJ5wQ=;
        b=G0h9gIl8ZKADVHVOneNDF/FRELDl38tIXhahkRCHJk6Khg9uLq59VMQ1iNfmMXJoBd
         +IS0GoP04MGkPHitkYmoVwy8KvwZmkgwqlCIng3sXlDQzfFKvt1/ljgKJ6GzwiRiruTa
         pm3Y8cHliGw8QUYFT0y/MnQrjjoJ4o+KRI3Jj5E9FaBHbqYmayavz5qz2Zfcf+bvxBjd
         qSnVzLXxrxFob8NbaLgQgJq2KuERMmKFyuoaPt2v/ZIkuNNUQXC0Xqnz30rPRVWROsr2
         quba9Nd8Bundqbnt0Op+AsMVfo3VrMC/ZUZuXsCMUBgV4SEeldBM8rcUlbhzgLKA9mTm
         aeFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9yPpuGxOnrpQMuh0V1j10HwBDVy4C1lNxbbW5m2nX+CKVZZ1UgjzI0GbJF0fd3WFSLyAyrE4KjzwM8w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1DpnQO3Ny/yu8eHlwwFc2SrtUVQmZJZI/u6REK3UNxcez/M6l
	kgZhJWCSehPmN+Ayuy9/zeQFYxtWc7u3/PiEcuTIsOKNk4w7VZ8Fsojm
X-Gm-Gg: ATEYQzxxoxueI5/C/tnhKjbv9jG2K5+QvFVYY2DirAai5NFY2e21fWZST8AI7qqrxTG
	DTj3yREjlqN8yX1JzMAzzIktApZjPZgi1okT3PzKgJrhUTd+H0b0Z8rfwc/gFbOND9s/0BPgMAV
	0nWdNQcyLKFGJiMMaPozMLPPpG0767dm6bZQt7opZC2PkfbPtmjOXdd18j1HsoXuaPrKh+m8Pbk
	rwko95AThOK4t/2VML+ivrSAk2ZaV8h3/1deVBITuS2bYWN1Gx2n9bs+N8l7h5vsfEYpH+AFSIP
	NUjmDwajC0BaQj4ypvBbORPXCEBJZyMGOO0SKyP16JVPaWu2LMADOJ/c5gdGO5QgixVOfokWtPi
	kk1sTDpB+JWxlSyFCF/pglDrxcfQbJ6/+sKvz/Y1AhSh8fU2u1gP3wioXZDOjz2h8guRPmfnNDu
	b5ElUx0A0KWY48vSuJ6c1ijcPfRlf+L+KsjpUTXZhxhCK7NeabP2bKr3zg
X-Received: by 2002:a05:6000:3103:b0:439:bcdb:95af with SMTP id ffacd0b85a97d-43b63ff0ee7mr17588578f8f.0.1774264750153;
        Mon, 23 Mar 2026 04:19:10 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm31308860f8f.14.2026.03.23.04.19.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Mar 2026 04:19:09 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: singhutkal015@gmail.com
Cc: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] erofs-utils: lib: switch ZSTD decompression to streaming API
Date: Mon, 23 Mar 2026 16:49:01 +0530
Message-ID: <20260323111901.44548-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323052257.11377-1-singhutkal015@gmail.com>
References: <20260323052257.11377-1-singhutkal015@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2952-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 5803E2F1154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

Can I test and verify this patch?

Thanks,
Nithurshen

