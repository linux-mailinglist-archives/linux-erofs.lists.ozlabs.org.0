Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E56F3B88C9
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Jun 2021 20:53:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFVqn0mb1z2yyb
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jul 2021 04:53:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1625079237;
	bh=bCU52emRu5nJdSfVlU9aa9NFztPhAlfWE3uNPcFWgR4=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I5dzfCjNPetxUJHK67x8XlX31odInoJLzUyKnjNW5rRL+6HuyqtUKd59gjVZLLTPG
	 dYbBqGGPIR0kHHL0q9jzr7ydQpvpo9rd66W5FHJ/NV+srN2CwBlRZ52dkanwYJ9wd0
	 RGBiVcuytefpjOOm5Udr7CfS63BX82NZmMxl5dn3R60xKGE/nyuXL42tbPMZ/LJ27B
	 tKqqKekQVTj5sGVzxvNyAHyhOrEuri3HBKYikIiX6pCpZOJN1GAvS7wIuZsEOOB4Az
	 hXarTu8Y0UMrWrKETwtDddwLZlxmksYpQokKupeH65JyFUyXfBAxal8uW28dord7hm
	 9SB90OGHpXS1w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=fb.com
 (client-ip=67.231.145.42; helo=mx0a-00082601.pphosted.com;
 envelope-from=prvs=6815496fc0=terrelln@fb.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=fb.com header.i=@fb.com header.a=rsa-sha256
 header.s=facebook header.b=nIuzPRwe; dkim-atps=neutral
X-Greylist: delayed 3845 seconds by postgrey-1.36 at boromir;
 Thu, 01 Jul 2021 04:53:50 AEST
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFVqf24h6z2xvL
 for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jul 2021 04:53:48 +1000 (AEST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15UHkTDS000787; Wed, 30 Jun 2021 10:49:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 39gagnegar-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 30 Jun 2021 10:49:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 10:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV2T73MzFE5gxvXAFdvPkn/6d62lgSqvFBbT/tF3xi5t4nWA0sn1JSejwhJLWGp8Atzo1Y+lR9SxZwBHdjO9w6rpLmWor1juV04ilinLy8aW3B0QK4DuIiL13sYCN71419vaTd72y+jeN9F7XZ0HArV3MA8zpLaRmQqaH2fLLfyuTCPBBKgVyQft8hXumea79odKzlf+RgTHNwg+WKoc//JkQcA5vRsT6bYt8sp/TL0U6m+xbds9VWu/Z5VJ1XB48mFu04PeEWBUJ+86vhrOHgbtykFIju2Bty5DjzyGrMVWyte3gyEx0EXuwpjwkvicvBvNrCkapOU/RFzWKIpTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCU52emRu5nJdSfVlU9aa9NFztPhAlfWE3uNPcFWgR4=;
 b=F27JJfXAc6I5cOvyz/0DX3ocJIi1pG6r6wE9kw5AVPcUyp9GKmSIuzy2sM26RhOEFIGBr8FS6v3zr7GylQLrz36scn+N9BXvG+yBxx9VSjybBM3uUdXXfYSvlA8S9bHbp4qLDxu4Dv3xfi3ZGw66tI+MoJGYoZp7nCcxZua+sDg88l57pAHjWobwuwzb8V2l5GDTiYn+kea6N7CM3ngGV0Y0/sypvvi+XALyWhe7pUI7WJDxVFbflXRIjbiEsfBWegSwZivuTwZl40jWzx4CU5fM+bOxRn9bGxQoRjBeh74G1kf83mnHaa/BcXC9wd+h5ps6wrM9a1k8OuTk6+2lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB4246.namprd15.prod.outlook.com (2603:10b6:a03:10e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 17:49:12 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::5d5e:c1c5:ad2c:121d]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::5d5e:c1c5:ad2c:121d%5]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 17:49:12 +0000
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] lz4: fixs use-after-free Read in
 LZ4_decompress_safe_partial
Thread-Topic: [PATCH] lz4: fixs use-after-free Read in
 LZ4_decompress_safe_partial
Thread-Index: AQHXbWAwiI7jc5ApMUaaIE5z2GMdJassb0eAgABmb4A=
Date: Wed, 30 Jun 2021 17:49:12 +0000
Message-ID: <CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com>
References: <20210630032358.949122-1-cy.fan@huawei.com>
 <YNxYqXhw5g7Nl3JP@B-P7TQMD6M-0146.local>
In-Reply-To: <YNxYqXhw5g7Nl3JP@B-P7TQMD6M-0146.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:c0b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bff59a9-6a8f-4ce8-5dbc-08d93bef5ed8
x-ms-traffictypediagnostic: BYAPR15MB4246:
x-microsoft-antispam-prvs: <BYAPR15MB424651F0DC83C1C71E749F6DAB019@BYAPR15MB4246.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sY0Y/yF7an2YfClKexl5nLv8ZXsxuAHaj1eYCM72ASSTw2prjfX4IwaVJByqUpGFYTcKXH+/sV8qWAs4CfikSUISt2MqmdusE6ariUBgNbEc51hAr8r59PfmMwhwHJzZdQi7oTls6ctxafOf6AGmd2+OIShIAZxCWkZW5whZHrghGTVwR5qzD+RNuQ01iKk2N2av/BiWFlyU5RHyvF1c/YmmmTJ9Gi8oaigqs+Xaj/Zoy2mAANuOhY8DaovzhJMCyI6Z51izdV6cO2f+RiNwYg3mxhbxf4dlVb4r3bzgozwp08mIQQDWNM5ghN+bkClgwHoCIJ8AOkZk7r6i4Mv80r4hiMEHJQhhuvOj9WAr44vwWXO6PdtEJq1pMKr9nlCTQASkZB6Iq9RIqVaTNRoc/oW9n1aVXI3XZwHdcTxWBdpr7g8VMKi2Y1ClZoUX9w5EJIozJ3me931Je4eWMTTpCVO30Z+i7AC7QGCxzqobX5o8xd5/6Z6w3ZTk7Rvjknj4tLHYnA9PhK6zDRPi2JjsvM4VfZ03VvgAFahZQgH5u4JnzRrRBgsQtkavoLkow2zIoq0aTaK4Na65so3+IJt7D8BCG7VGdIpbjUqVWfn9IN6L9CUbVHeKmfvjRCLycl7bi0QERbXkqySAJkpRWof0ijWsxlRBKd92oKdpXIA1S7+dEeJijTtDjG8B8/ByadTbfJjP99XQRmvbH/P8GEOlGF2rg2oAQkzaNRiHfiGzxphuZQxLywRQSwudOguBsVisGNzlWJPcR8+0wcfimlyCtcXVAnX3NfNUPmFXitXngQPVfachX5syHm3t8OjL9sUovuZFwoXyTJ7CeF2+VCp0WilE1GhZUpWa6/bHzfg7qknkpJN01zMHjsE5lDxTE5FqXk0sxnwa690TSsE1GaPy1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR15MB3667.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(8936002)(38100700002)(8676002)(316002)(122000001)(53546011)(6506007)(186003)(2616005)(83380400001)(76116006)(478600001)(2906002)(66476007)(66556008)(71200400001)(4326008)(66446008)(966005)(64756008)(33656002)(86362001)(66946007)(6486002)(6916009)(6512007)(5660300002)(54906003)(36756003)(45980500001)(505234006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDgyajBjOUV2SFdBb3lGT1Nxc2xCMDhRRksvWmlIaGNrOUw4YmpOTWxYRmNs?=
 =?utf-8?B?VW52RnhQVEVPNzRNNGZXQ1NTclQ3anVvV2doSlpRdmpHTFlpTFRuN3p3NG5J?=
 =?utf-8?B?MDBjSzVzZ21OQlF3MVlsVjhnYmh3TVhUQXFKekd2TFdGbWFNZXBsb2gvalpU?=
 =?utf-8?B?cXZ4MHMwSUZkTlFGSGlqcGl4ZTlaV0dYam8yZmYweWVtRWRhcFlMZUVLeVhS?=
 =?utf-8?B?akovdGdmc0h6YWtwWkJBRUtyOW5neDNvRW16dzhlQlBadlhGRFEvUm5PVjd1?=
 =?utf-8?B?cC93cjY5K3FqS2orS3VhTUwyb2drUHpvaHpsWHczOW10Z3d3WmNZMHhSd3pt?=
 =?utf-8?B?eDhOL2pVVTNpSFBvZkYraHF5SXovcVJDd2lHWWFwa20wRSs0ZkFkSDd0RmEz?=
 =?utf-8?B?ZmFqOFh1aDBCYVVwbmlyY3J6YnQvTThYTjdFcEJyNTN3VGlQV1g4QStkdjF1?=
 =?utf-8?B?TW1wMWl1WUVFVi9DS3ZpNEFsUXVHVnhXbXdlTVNiNnhuK1hyUUw2T09udGFP?=
 =?utf-8?B?c3d6Z3hwWkNobnlZUXJZY0JtRHJpTWJsbWJpclMvc0tMWGJWcWJIVnV2aHpF?=
 =?utf-8?B?aTBuY3o5cmNtRXJwWThEWmlCMDU2VVVUazV5T2ZpMStLdU8wSy8rbTIvR2pU?=
 =?utf-8?B?L20rc0pUdlpEdXJQcThBdFJQR002QnJseGE3N0YzTVB4dm5NN3RlR1FNWi9Z?=
 =?utf-8?B?WiszR01OY2dpb1FEb0RzSlBZak1RSjZ0ejdob0xTUFhFOHVuRG5rb1YrR0ZQ?=
 =?utf-8?B?NGNZRGZWTW8wUXlmL2ZFbVdoZm5IblVFRjBoS056ZW52dnk5Zzd1NGNXQ3FY?=
 =?utf-8?B?ZW1zOVlVNjREQS9DYUxyd1BmNjlyZXZod0pTaDZDRStGRVkxTzQ0NFhIeFU2?=
 =?utf-8?B?Z1loVk9VRElZb1BSSFJiVS85SE0rVnd0OG5zUWxHdlNPZnp0eUVYN1Z2Qlpv?=
 =?utf-8?B?eDg1RlUrNHhGTVFBYmIyaUxjMnlsaHhNNTgxUGJ1VCtYWTkzYW43VmJSR1Fy?=
 =?utf-8?B?OEJEUHFpZVYyem9pMlorcXl0ZkRsdU9UaWFURFZhUnlpVjI4WGZlMHFqZWU1?=
 =?utf-8?B?MDc4SWVlUVlBeCsxdnBRazZhdlJKeFZ3UUxMaFR6eHZTTE1MVEtKZWFjYitL?=
 =?utf-8?B?Sk5LMnFGS096Q0NjMXVOMWlycnFxQks4dDVEcVkva2VTanYrSlVOcmFPcllk?=
 =?utf-8?B?Skc2QzF4d0ttbTU0eXJaTHZaeFNsNlM3NkgweFUwanh5UTlhTEpGL2NhYzg2?=
 =?utf-8?B?QURVQUpNVWRwZ0x3cG0vQjc2Umt1eDZtS3RXNVRscmZSRjJFWncrS0VmbzVF?=
 =?utf-8?B?Z1RIc3NwZUN2cTJTVmJFVG1OZW5ic3M4WTRTT3Z1STFQK2JSRzczL3FyWTBC?=
 =?utf-8?B?UHBHeTJPV2JMREdTK2pCaWRTR21zVHFCQlhKU2lqY0ZMSHo3NXQxYjFuWEdk?=
 =?utf-8?B?a25RTitodUlPZ0Z2ZUtncUF0YjZ2ZW5UOTVwUEZ3a2QxeFlHakN5b2pGMUZa?=
 =?utf-8?B?eGFFd0d3VVNDOTgybUhkekhtUXZBZkF6MWNyY21ubEdRQzZ6T0lCTXVMT3JO?=
 =?utf-8?B?c3hhZXlDWmNzblkxc3BQblBzeGNnYW5OZllTRURVclE4SyswZHAvSVZiS0Qv?=
 =?utf-8?B?KzUwZEZUdXkyZmdRV0FoMTVwbU9pVm9PcFF1N0MzRzBDNTFaOFBNV2puTVFa?=
 =?utf-8?B?djJsdEZWZ3VhYlBxdGwwcERncFIxUFhzVllZK3ZkWWpEb3hNL3NYOTVWaFBB?=
 =?utf-8?B?Rm5ramRPM1A5bXVPK1FrSXZZaldNcTExQnZlS1FKaWJNT05XNEpIME1TSnAv?=
 =?utf-8?Q?K3WExVB8t64k1IdGlfB4k6NV640BflPrmbTYc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EAF4370737C4F4BB3132DBE44620668@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bff59a9-6a8f-4ce8-5dbc-08d93bef5ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 17:49:12.3536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHvcGHSJ+SRhxDsdnOOre/gVTjDWHX16r314YQ+/JVXKRnr6fKHTSER5Ub6MhmCm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4246
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: eNlmXa05gwZ5d6mDFU-7v2j0xpVg6GZO
X-Proofpoint-GUID: eNlmXa05gwZ5d6mDFU-7v2j0xpVg6GZO
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-30_08:2021-06-30,
 2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 clxscore=1011
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300098
X-FB-Internal: deliver
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Nick Terrell via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Nick Terrell <terrelln@fb.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Yann
 Collet <yann.collet.73@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Chengyang Fan <cy.fan@huawei.com>, Rajat Asthana <thisisrast7@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

DQoNCj4gT24gSnVuIDMwLCAyMDIxLCBhdCA0OjQyIEFNLCBHYW8gWGlhbmcgPGhzaWFuZ2thb0Bs
aW51eC5hbGliYWJhLmNvbT4gd3JvdGU6DQo+IA0KPiAoYWxzbyArY2MgWWFubiBhcyB3ZWxsIGFz
IE5pY2suLikNCj4gDQo+IEhpIENoZW5neWFuZywNCj4gDQo+IElmIEkgdW5kZXJzdGFuZCBjb3Jy
ZWN0bHksIGlzIHRoaXMgYSBtYW51YWxseSBwcm9kdWNlZCBmdXp6ZWQNCj4gRVJPRlMgY29tcHJl
c3NlZCBkYXRhPyBJZiBpdCdzIGp1c3QgYSBub3JtYWwgaW1hZ2UsIGNvdWxkIHlvdQ0KPiBhbHNv
IHNoYXJlIHRoZSBvcmlnaW5hbCBpbWFnZT8NCj4gDQo+IE9uIFdlZCwgSnVuIDMwLCAyMDIxIGF0
IDExOjIzOjU4QU0gKzA4MDAsIENoZW5neWFuZyBGYW4gd3JvdGU6DQo+PiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+
IEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIGdldF91bmFsaWduZWRfbGUxNiBpbmNsdWRl
L2xpbnV4L3VuYWxpZ25lZC9hY2Nlc3Nfb2suaDoxMCBbaW5saW5lXQ0KPj4gQlVHOiBLQVNBTjog
dXNlLWFmdGVyLWZyZWUgaW4gTFo0X3JlYWRMRTE2IGxpYi9sejQvbHo0ZGVmcy5oOjEzMiBbaW5s
aW5lXQ0KPj4gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4gTFo0X2RlY29tcHJlc3NfZ2Vu
ZXJpYyBsaWIvbHo0L2x6NF9kZWNvbXByZXNzLmM6MjgxIFtpbmxpbmVdDQo+PiBCVUc6IEtBU0FO
OiB1c2UtYWZ0ZXItZnJlZSBpbiBMWjRfZGVjb21wcmVzc19zYWZlX3BhcnRpYWwrMHhmNTAvMHgx
NDgwIGxpYi9sejQvbHo0X2RlY29tcHJlc3MuYzo0NjUNCj4+IFJlYWQgb2Ygc2l6ZSAyIGF0IGFk
ZHIgZmZmZjg4ODAxNzg1MTAwMCBieSB0YXNrIGt3b3JrZXIvdTEyOjAvMjA1Ng0KPj4gDQo+PiBD
UFU6IDAgUElEOiAyMDU2IENvbW06IGt3b3JrZXIvdTEyOjAgTm90IHRhaW50ZWQgNS4xMC40MCAj
Mg0KPj4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5
NiksIEJJT1MgVWJ1bnR1LTEuOC4yLTF1YnVudHUxIDA0LzAxLzIwMTQNCj4+IFdvcmtxdWV1ZTog
ZXJvZnNfdW56aXBkIHpfZXJvZnNfZGVjb21wcmVzc3F1ZXVlX3dvcmsNCj4+IENhbGwgVHJhY2U6
DQo+PiBfX2R1bXBfc3RhY2sgbGliL2R1bXBfc3RhY2suYzo3NyBbaW5saW5lXQ0KPj4gZHVtcF9z
dGFjaysweDEzNy8weDFiZSBsaWIvZHVtcF9zdGFjay5jOjExOA0KPj4gcHJpbnRfYWRkcmVzc19k
ZXNjcmlwdGlvbisweDZjLzB4NjQwIG1tL2thc2FuL3JlcG9ydC5jOjM4NQ0KPj4gX19rYXNhbl9y
ZXBvcnQgbW0va2FzYW4vcmVwb3J0LmM6NTQ1IFtpbmxpbmVdDQo+PiBrYXNhbl9yZXBvcnQrMHgx
M2QvMHgxZTAgbW0va2FzYW4vcmVwb3J0LmM6NTYyDQo+PiBnZXRfdW5hbGlnbmVkX2xlMTYgaW5j
bHVkZS9saW51eC91bmFsaWduZWQvYWNjZXNzX29rLmg6MTAgW2lubGluZV0NCj4+IExaNF9yZWFk
TEUxNiBsaWIvbHo0L2x6NGRlZnMuaDoxMzIgW2lubGluZV0NCj4+IExaNF9kZWNvbXByZXNzX2dl
bmVyaWMgbGliL2x6NC9sejRfZGVjb21wcmVzcy5jOjI4MSBbaW5saW5lXQ0KPj4gTFo0X2RlY29t
cHJlc3Nfc2FmZV9wYXJ0aWFsKzB4ZjUwLzB4MTQ4MCBsaWIvbHo0L2x6NF9kZWNvbXByZXNzLmM6
NDY1DQo+PiB6X2Vyb2ZzX2x6NF9kZWNvbXByZXNzKzB4ODM5LzB4YzkwIGZzL2Vyb2ZzL2RlY29t
cHJlc3Nvci5jOjE2Mg0KPj4gel9lcm9mc19kZWNvbXByZXNzX2dlbmVyaWMgZnMvZXJvZnMvZGVj
b21wcmVzc29yLmM6MjkxIFtpbmxpbmVdDQo+PiB6X2Vyb2ZzX2RlY29tcHJlc3MrMHg1N2UvMHhl
MTAgZnMvZXJvZnMvZGVjb21wcmVzc29yLmM6MzQ0DQo+PiB6X2Vyb2ZzX2RlY29tcHJlc3NfcGNs
dXN0ZXIrMHgxM2QxLzB4MjMxMCBmcy9lcm9mcy96ZGF0YS5jOjg4MA0KPj4gel9lcm9mc19kZWNv
bXByZXNzX3F1ZXVlIGZzL2Vyb2ZzL3pkYXRhLmM6OTU4IFtpbmxpbmVdDQo+PiB6X2Vyb2ZzX2Rl
Y29tcHJlc3NxdWV1ZV93b3JrKzB4ZGUvMHgxNDAgZnMvZXJvZnMvemRhdGEuYzo5NjkNCj4+IHBy
b2Nlc3Nfb25lX3dvcmsrMHg3ODAvMHhmYzAga2VybmVsL3dvcmtxdWV1ZS5jOjIyNjkNCj4+IHdv
cmtlcl90aHJlYWQrMHhhYTQvMHgxNDYwIGtlcm5lbC93b3JrcXVldWUuYzoyNDE1DQo+PiBrdGhy
ZWFkKzB4MzlhLzB4M2MwIGtlcm5lbC9rdGhyZWFkLmM6MjkyDQo+PiByZXRfZnJvbV9mb3JrKzB4
MWYvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TOjI5Ng0KPj4gDQo+PiBUaGUgYnVnZ3kg
YWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwYWdlOg0KPj4gcGFnZTowMDAwMDAwMGE3OWI3NmYxIHJl
ZmNvdW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAgaW5kZXg6MHgwIHBm
bjoweDE3ODUxDQo+PiBmbGFnczogMHhmZmYwMDAwMDAwMDAwMCgpDQo+PiByYXc6IDAwZmZmMDAw
MDAwMDAwMDAgZmZmZmVhMDAwMDgxYjljOCBmZmZmZWEwMDAwNmFjNmM4IDAwMDAwMDAwMDAwMDAw
MDANCj4+IHJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwZmZm
ZmZmZmYgMDAwMDAwMDAwMDAwMDAwMA0KPj4gcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJh
ZCBhY2Nlc3MgZGV0ZWN0ZWQNCj4+IA0KPj4gTWVtb3J5IHN0YXRlIGFyb3VuZCB0aGUgYnVnZ3kg
YWRkcmVzczoNCj4+IGZmZmY4ODgwMTc4NTBmMDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo+PiBmZmZmODg4MDE3ODUwZjgwOiAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPj4+IGZmZmY4ODgwMTc4NTEwMDA6
IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmDQo+PiAgICAg
ICAgICAgICAgICAgICBeDQo+PiBmZmZmODg4MDE3ODUxMDgwOiBmZiBmZiBmZiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZg0KPj4gZmZmZjg4ODAxNzg1MTEwMDogZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYNCj4+ID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
Pj4gZXJvZnM6IChkZXZpY2UgbG9vcDApOiB6X2Vyb2ZzX2x6NF9kZWNvbXByZXNzOiBmYWlsZWQg
dG8gZGVjb21wcmVzcyAtNDA5OSBpbls0MDk2LCAwXSBvdXRbOTAwMF0NCj4+IA0KPj4gT2ZmLWJ5
LW9uZSBlcnJvciBjYXVzZXMgdGhlIGFib3ZlIGlzc3VlLiBJbiBMWjRfZGVjb21wcmVzc19nZW5l
cmljKCksDQo+PiBgaWVuZCA9IHNyYyArIHNyY1NpemVgLiBJdCBtZWFucyB0aGUgdmFsaWQgYWRk
cmVzcyByYW5nZSBzaG91bGQgYmUNCj4+IFtzcmMsIGllbmQgLSAxXS4gVGhlcmVmb3JlLCB3aGVu
IGNoZWNraW5nIHdoZXRoZXIgdGhlIHJlYWRpbmcgaXMNCj4+IG91dC1vZi1ib3VuZHMsIGl0IHNo
b3VsZCBiZSAgYD49IGllbmRgIHJhdGhlciB0aGFuIGA+IGllbmRgLg0KDQpUaGlzIGlzbuKAmXQg
Y29ycmVjdC4gVGhlIGJvdW5kcyBjaGVjayBpcyBjb3JyZWN0IGZvciB0aGUgZm9sbG93aW5nIG1l
bWNweSgpLg0KVGhlIHByb2JsZW0gaXMgdGhlIExaNF9yZWFkTEUxNigpIG9uIGxpbmUgMjg1IFsx
XS4NCg0KPj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2hlbmd5YW5nIEZhbiA8Y3kuZmFuQGh1YXdlaS5jb20+DQo+PiAtLS0N
Cj4+IGxpYi9sejQvbHo0X2RlY29tcHJlc3MuYyB8IDIgKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvbGliL2x6
NC9sejRfZGVjb21wcmVzcy5jIGIvbGliL2x6NC9sejRfZGVjb21wcmVzcy5jDQo+PiBpbmRleCA5
MjZmNDgyM2Q1ZWEuLmVjNTE4MzdjZDMxZiAxMDA2NDQNCj4+IC0tLSBhL2xpYi9sejQvbHo0X2Rl
Y29tcHJlc3MuYw0KPj4gKysrIGIvbGliL2x6NC9sejRfZGVjb21wcmVzcy5jDQo+PiBAQCAtMjM0
LDcgKzIzNCw3IEBAIHN0YXRpYyBGT1JDRV9JTkxJTkUgaW50IExaNF9kZWNvbXByZXNzX2dlbmVy
aWMoDQo+PiAJCQkJCWxlbmd0aCA9IG9lbmQgLSBvcDsNCj4+IAkJCQl9DQo+PiAJCQkJaWYgKChl
bmRPbklucHV0KQ0KPj4gLQkJCQkJJiYgKGlwICsgbGVuZ3RoID4gaWVuZCkpIHsNCj4+ICsJCQkJ
CSYmIChpcCArIGxlbmd0aCA+PSBpZW5kKSkgew0KPiANCj4gSSdtIG5vdCBzdXJlIGl0IHNob3Vs
ZCBiZSBmaXhlZCBhcyB0aGlzLg0KDQpZZWFoLCB0aGlzIGlzIG5vdCB0aGUgY29ycmVjdCBmaXgu
IGBpcCArIGxlbmd0aCA+IGllbmRgIGlzIGNvcnJlY3QgZm9yIHRoZQ0KbWVtY3B5KCkuIFlvdSB3
b3VsZCBpbnN0ZWFkIG5lZWQgdG8gYWRkIGFub3RoZXIgY2hlY2sgYWZ0ZXIgdGhlDQptZW1jcHko
KS4gRS5nLiBzb21ldGhpbmcgbGlrZSB0aGlzLCB0YWtlbiBmcm9tIHVwc3RyZWFtIFsyXS4NCg0K
YGBgDQoNCgkJCUxaNF9tZW1tb3ZlKG9wLCBpcCwgbGVuZ3RoKTsNCgkJCWlwICs9IGxlbmd0aDsN
CgkJCW9wICs9IGxlbmd0aDsNCg0KCQkJLyogTmVjZXNzYXJpbHkgRU9GLCBkdWUgdG8gcGFyc2lu
ZyByZXN0cmljdGlvbnMgKi8NCi0JCQlpZiAoIXBhcnRpYWxEZWNvZGluZyB8fCAoY3B5ID09IG9l
bmQpKQ0KKwkJCWlmICghcGFydGlhbERlY29kaW5nIHx8IChjcHkgPT0gb2VuZCkgfHwgKGlwID49
IChpZW5kLTIpKSkNCgkJCQlicmVhazsNCmBgYA0KDQpUaGlzIHNob3VsZCBiZSBlbm91Z2ggdG8g
Zml4IHRoZSBvdXQgb2YgYm91bmRzIHJlYWQgeW91IHJlcG9ydGVkLg0KSG93ZXZlciwgSSBjYW7i
gJl0IGd1YXJhbnRlZSB0aGF0IHRoaXMgd2lsbCBmaXggYWxsIHRoZSBpc3N1ZXMgdGhhdCBoYXZl
IGJlZW4NCmZpeGVkIHVwc3RyZWFtIHNpbmNlIHYxLjguMy4NCg0KVGhlIHNhZmVzdCBhbmQgbW9z
dCByb2J1c3QgY291cnNlIG9mIGFjdGlvbiB3b3VsZCBiZSB0byB1cGRhdGUgdGhlIHZlcnNpb24N
Cm9mIExaNCBpbiB0aGUga2VybmVsIHRvIHRoZSBsYXRlc3QgdXBzdHJlYW0sIHdoaWNoIGlzIGNv
bnRpbnVvdXNseSBmdXp6ZWQsIGFuZA0KZG9lc24ndCBoYXZlIHRoaXMgaXNzdWUuDQoNCkJlc3Qs
DQpOaWNrIFRlcnJlbGwNCg0KPiBUaGUgY3VycmVudCBsejQgZGVjb21wcmVzc2lvbiBjb2RlIHdh
cyBmcm9tIGx6NCAxLjguMywgYW5kIEkgc2F3DQo+IHNldmVyYWwgZm9sbG93aW5nIHVwIGZpeGVz
IGZvciBpbmNvbXBsZXRlIGlucHV0IHBhcnRpYWwgZGVjb2RpbmcNCj4gaW4gcmVjZW50IExaNCB1
cHN0cmVhbSwgeW91IGNvdWxkIGNoZWNrIHRoZW0gb3V0IHRvZ2V0aGVyLiBIb3dldmVyLA0KPiBF
Uk9GUyBzaG91bGQgbmV2ZXIgcGFzcyBpbmNvbXBsZXRlIGx6NCBjb21wcmVzc2VkIGRhdGEgdG8g
dGhlIExaNA0KPiBzaWRlIHVubGVzcyBpdCdzIHNvbWV3aGF0IGEgY29ycnVwdGVkIGltYWdlIG9u
IHB1cnBvc2UuDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L2JsYW1lL2Rldi9saWIvbHo0
LmMNCj4gDQo+IFRoYW5rcywNCj4gR2FvIFhpYW5nDQo+IA0KPj4gCQkJCQkvKg0KPj4gCQkJCQkg
KiBFcnJvciA6DQo+PiAJCQkJCSAqIHJlYWQgYXR0ZW1wdCBiZXlvbmQNCj4+IC0tIA0KPj4gMi4x
OC4wLmh1YXdlaS4yNQ0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvMDA3YjM1MGE1ODc1NGE5M2NhOWZlNTBjNDk4Y2MyNzc4MDE3MTE1My9saWIvbHo0L2x6NF9k
ZWNvbXByZXNzLmMjTDI4NQ0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L2Jsb2IvMTFl
ZmM5NWMzZjAyYjc2YWI0MGU3ZmJkNjA1Njc3YWQ2ZWIxNDFkMy9saWIvbHo0LmMjTDIwNTkNCg0K
DQo=
